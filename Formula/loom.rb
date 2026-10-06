class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "${VERSION}"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v${VERSION}.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v${VERSION}"
    sha256 cellar: :any, arm64_sonoma: "358c43bebf087789c357356c297e21339dbe91d61939fee2e90f71b575c7541f"
    sha256 cellar: :any, arm64_tahoe: "de7f1138edb16439d87124c89cc32fb4aa5f04f73b5e4e26b3fb6e93761199c9"
    sha256 cellar: :any, x86_64_tahoe: "7c1eb29c4d64f37c376aa15536a2271521b5fee8ff4cd8ddea36fc1ec631a555"
  end

  depends_on "rust" => :build

  def install
    bin.install "bin/loom"
    bin.install "bin/loomd"
  end

  service do
    run [opt_bin/"loomd"]
    working_dir Dir.home
    keep_alive true
  end

  test do
    assert_match "Loom", shell_output("\#{bin}/loom --help")
  end
end
