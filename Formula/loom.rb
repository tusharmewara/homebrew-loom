class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.9.4"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.9.4.tar.gz"
  sha256 "10d955f155d2a9b60caf113063fa28e09733178c8e126d747961afd955e4bd67"

  bottle do
    root_url "https://github.com/tusharmewara/loom/releases/download/v0.9.5"
    sha256 cellar: :any, arm64_sonoma: "b4fcfd264a4523d2dfb98b44de50a81fd799a7465a81e1f50a0817bff0f3255f"
    sha256 cellar: :any, sonoma: "17ffb3e9031f8f29ea14584c271bc361be9deaff63e3e7f2797ace0af356a846"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4c94c389f76dd3e136176a9cc17c019318b343d869ff489b92672696b497e78d"
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
