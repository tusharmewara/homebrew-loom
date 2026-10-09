class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.9.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.9.2.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.9.2"
    sha256 cellar: :any, arm64_sonoma: "77f61bb2cdadfffa8c95f93186d0ee1dd0db809caa6a474ef2809412a16b6707"
    sha256 cellar: :any, arm64_tahoe: "e04e54439c8028904d3b9a14581c4b1e632e60811d476f6a6a0facb23622d3f8"
    sha256 cellar: :any, sonoma: "2adb722a7b969b90a86ac926445bbdd129a355298da99bcb52139e5c349d922f"
    sha256 cellar: :any, tahoe: "ddfddc111b1a7eccbba519525dad57726f9e0a912daf9bf59a009d9545c8024d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5fe48c02f1306151e6049cc45d03c303a172ad269e6c323b329578b02ff95f97"
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
