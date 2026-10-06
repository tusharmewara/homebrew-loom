class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.9.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "5c04b0f9cdae5b90d64affdcdf3182ec7393e25e4dcc448ffe7683b9a19dabe7"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.9.1"
    sha256 cellar: :any, arm64_sonoma: "358c43bebf087789c357356c297e21339dbe91d61939fee2e90f71b575c7541f"
    sha256 cellar: :any, arm64_tahoe: "de7f1138edb16439d87124c89cc32fb4aa5f04f73b5e4e26b3fb6e93761199c9"
    sha256 cellar: :any, tahoe: "7c1eb29c4d64f37c376aa15536a2271521b5fee8ff4cd8ddea36fc1ec631a555"
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
    assert_match "Loom", shell_output("#{bin}/loom --help")
  end
end
