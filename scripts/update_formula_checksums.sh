#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-0.1.0}"
FORMULA_FILE="${2:-Formula/loom.rb}"
OUTPUT_FILE="checksums.txt"

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
RELEASE_DATA=$(curl -s "https://api.github.com/repos/tusharmewara/loom/releases/latest")
if [ -z "$RELEASE_DATA" ]; then
  echo "Error: Could not fetch release data."
  exit 1
fi

# Verify version matches
RELEASE_VERSION=$(echo "$RELEASE_DATA" | jq -r '.tag_name' | sed 's/^v//')
if [ "$RELEASE_VERSION" != "$VERSION" ]; then
  echo "Warning: Release version ($RELEASE_VERSION) does not match requested version ($VERSION)."
  read -p "Continue with $RELEASE_VERSION instead? (y/N): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
  VERSION="$RELEASE_VERSION"
fi

# Filter assets: only bottles (tarballs with platform names)
echo "Filtering bottle assets..."
echo "$RELEASE_DATA" | jq -r '.assets[] | select(.name | test("loom--'$VERSION'--[a-z0-9_]+.tar.gz")) | "\(.name) \(.browser_download_url)"' > assets_list.txt

if [ ! -s assets_list.txt ]; then
  echo "No bottle assets found for version $VERSION."
  echo "Make sure the release has bottle tarballs uploaded."
  exit 1
fi

echo "Found bottle assets:"
cat assets_list.txt | sed 's/^/  - /'
echo ""

# Download and checksum
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "Downloading bottles and computing checksums..."
> "$OUTPUT_FILE"
while read -r name url; do
  [ -z "$name" ] && continue
  platform="${name#loom--$VERSION--}"
  platform="${platform%.tar.gz}"
  echo "  • $platform"

  curl -sL "$url" -o "$TMPDIR/$name"
  sha=$(shasum -a 256 "$TMPDIR/$name" | cut -d' ' -f1)
  echo "@sha256_$platform = \"$sha\"" >> "$OUTPUT_FILE"
done < assets_list.txt

echo ""
echo "Checksums written to: $OUTPUT_FILE"
echo ""

# Update formula automatically if Ruby is available
if command -v ruby &>/dev/null; then
  echo "Updating formula automatically..."
  ruby -e '
    checksums = {}
    if File.exist?("'"$OUTPUT_FILE"'")
      File.readlines("'"$OUTPUT_FILE"'").each do |l|
        if l =~ /^@sha256_(\w+)\s*=\s*"([^"]+)"/
          checksums[$1] = $2
        end
      end
    end

    content = File.read("'"$FORMULA_FILE"'")
    checksums.each do |platform, sha|
      content.gsub!(
        /(sha256 cellar: :any_skip_relocation,\s*#{platform}:\s*)"([^"]*)"/,
        "\\1\"#{sha}\""
      )
    end
    File.write("'"$FORMULA_FILE"'", content)
  '

  echo "Formula updated successfully!"
  echo ""
  echo "Next steps:"
  echo "  1. Review the changes: git diff $FORMULA_FILE"
  echo "  2. Commit: git commit -am \"Update bottle checksums for v$VERSION\""
  echo "  3. Push to your tap repository"
else
  echo "Ruby not found. Please update the formula manually:"
  echo "  Copy the values from $OUTPUT_FILE into the bottle block of $FORMULA_FILE"
fi
