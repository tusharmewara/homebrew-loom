class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.8.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "7695e6fbbbf453b20e37fe4585a2684c79a8caf82d040862330b73d46d5f8d66"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.8.1"
    sha256 cellar: :any, arm64_tahoe: "117bb7ab4f2b0df6fa615e01b21f5b5886b195a8ff68418c0360806cd3d672f3"
    sha256 cellar: :any, tahoe: "5d98a32f7ef96725e7fb77ba1c450ccbadce3f8a4e17ac2e0bfe5f1fc51a0d04"
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
