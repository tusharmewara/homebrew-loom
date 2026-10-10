class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.9.3"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.9.3.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.9.3"
    sha256 cellar: :any, arm64_sonoma: "d1a164284615b089f4a69ca066c5c43dc37aad36ee3a80d4d8bd434e27d0e457"
    sha256 cellar: :any, sonoma: "19887eaf5f6e85c74e00bc3cb44e83dc065893a9c56f21a34e212f06c9c2bf60"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e9c2c3cf200b5794de135821a413ba8e6865a46692abe92de169295225e639a6"

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
