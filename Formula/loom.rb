class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.8.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.8.2"
    sha256 cellar: :any, arm64_sonoma: "0ef01b250b422ad45b9d8c61dead2a8052be047935b50ac2a1738c724dd26165"
    sha256 cellar: :any, sonoma: "afbf69456466de27be0b9b1b730de80b2c198ce07c54074812953fe99771f9e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5f5adf513c622b4c8a2652fb5db4a3983724db7787be98592de62a7060254afd"

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
