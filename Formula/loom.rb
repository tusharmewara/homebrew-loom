class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.9.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.9.2.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.9.2"
    sha256 cellar: :any, arm64_sonoma: "358c43bebf087789c357356c297e21339dbe91d61939fee2e90f71b575c7541f"
    sha256 cellar: :any, arm64_tahoe: "e04e54439c8028904d3b9a14581c4b1e632e60811d476f6a6a0facb23622d3f8"
    sha256 cellar: :any, tahoe: "ddfddc111b1a7eccbba519525dad57726f9e0a912daf9bf59a009d9545c8024d"
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
