class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "${V}"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v${V}.tar.gz"
  sha256 "${SRC_SHA}"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v${V}"
    sha256 cellar: :any, 8.2.arm64_sonoma: "24bb093b051f9e743ab2c0dc2ac535fbe9558c2547caa7159b758354e04d5eec"
    sha256 cellar: :any, 8.2.sonoma: "9554ff2b83890bd20be18e477193a14fd347ad99209edac0c79ffc98719e4f9c"
    sha256 cellar: :any, 8.2.x86_64_linux: "8b0a42a67b0af534c6dd1a537900a8051eb22a9ab417f38392a2e6be0ea69d83"

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
