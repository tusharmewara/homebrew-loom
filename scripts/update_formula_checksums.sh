#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-0.1.0}"
FORMULA_FILE="${2:-Formula/loom.rb}"

echo "=== Loom Bottle Checksum Updater ==="
echo "Version: $VERSION"
echo "Formula: $FORMULA_FILE"
echo ""

# Verify required tools
for cmd in curl jq shasum; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: '$cmd' is required but not installed."
    exit 1
  fi
done

# Get release data
echo "Fetching release data from GitHub..."
RELEASE_DATA=$(curl -s "https://api.github.com/repos/tusharmewara/homebrew-loom/releases/tags/v$VERSION")

# Fall back to latest
if echo "$RELEASE_DATA" | jq -e '.message' &>/dev/null; then
  echo "Tag v$VERSION not found, falling back to latest..."
  RELEASE_DATA=$(curl -s "https://api.github.com/repos/tusharmewara/homebrew-loom/releases/latest")
fi

if [ -z "$RELEASE_DATA" ]; then
  echo "Error: Could not fetch release data."
  exit 1
fi

RELEASE_VERSION=$(echo "$RELEASE_DATA" | jq -r '.tag_name' | sed 's/^v//')
echo "Release tag: v$RELEASE_VERSION"

# Filter bottle assets
echo "Filtering bottle assets..."
echo "$RELEASE_DATA" | jq -r '.assets[] | select(.name | test("loom-'$RELEASE_VERSION'\\.(arm64_sequoia|arm64_sonoma|arm64_tahoe|sequoia|sonoma|tahoe|ventura|monterey)\\.bottle\\.tar\\.gz$")) | "\(.name) \(.browser_download_url)"' > assets_list.txt

if [ ! -s assets_list.txt ]; then
  echo "No bottle assets found for version $RELEASE_VERSION."
  cat assets_list.txt
  exit 1
fi

echo "Found bottle assets:"
cat assets_list.txt | sed 's/^/  - /'
echo ""

# Download and compute checksums
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "Downloading bottles and computing checksums..."
> checksums.txt
while read -r name url; do
  [ -z "$name" ] && continue
  # Extract platform from: loom--0.1.0.arm64_sequoia.bottle.tar.gz
  platform="${name#loom-$RELEASE_VERSION.}"
  platform="${platform%.bottle.tar.gz}"
  echo "  • $platform"

  curl -sL "$url" -o "$TMPDIR/$name"
  sha=$(shasum -a 256 "$TMPDIR/$name" | cut -d' ' -f1)
  echo "$platform=$sha" >> checksums.txt
done < assets_list.txt

echo ""
echo "Checksums computed:"
cat checksums.txt | sed 's/^/  /'
echo ""

# Update formula
echo "Updating formula..."

# Bump version
perl -i -pe "s/(version\s+\")([^\"]+)(\")/\${1}$RELEASE_VERSION\${3}/" "$FORMULA_FILE"

# Bump root_url version
perl -i -pe "s|(root_url\s+\"https://github\.com/tusharmewara/homebrew-loom/releases/download/v)[^\"]+\"|\${1}$RELEASE_VERSION\"|" "$FORMULA_FILE"

# Update source url and sha256 from loom repo tag
echo "  Updating source archive for v$RELEASE_VERSION..."
perl -i -pe "s|(url\s+\"https://github\.com/tusharmewara/loom/archive/refs/tags/v)[^\"]+\"|\${1}$RELEASE_VERSION.tar.gz\"|" "$FORMULA_FILE"
SOURCE_SHA=$(curl -sL "https://github.com/tusharmewara/loom/archive/refs/tags/v$RELEASE_VERSION.tar.gz" | shasum -a 256 | cut -d' ' -f1)
perl -i -pe "s/(?<=^  sha256 \")[^\"]+/\L$SOURCE_SHA/" "$FORMULA_FILE"

# Update sha256 for each platform
while IFS='=' read -r platform sha; do
  [ -z "$platform" ] && continue
  echo "  Updating sha256 for $platform..."

  # Match: sha256 cellar: :any, <platform>: "<old_sha>"
  perl -i -pe "s/(sha256\s+cellar:\s+:any,\s+$platform:\s+)\"[^\"]*\"/\${1}\"$sha\"/" "$FORMULA_FILE"
done < checksums.txt

echo ""
echo "Formula updated successfully!"
echo ""
echo "Next steps:"
echo "  1. Review: git diff $FORMULA_FILE"
echo "  2. Commit: git commit -m \"Update bottle checksums for v$VERSION\""
echo "  3. Push: git push"
