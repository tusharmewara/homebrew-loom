class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.8.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.8.2"
    sha256 cellar: :any, 8.2.arm64_sonoma: "bcdbfd44cc0c810944b053b294835db2614c10ed424e53d0d13162a7ad7c0c54"
    sha256 cellar: :any, 8.2.sonoma: "844760a47b606b03c0ce14830f84e7bceb372bd3ccae06934540b28492ee9f01"
    sha256 cellar: :any, 8.2.x86_64_linux: "41c996f38fd05f14c0c27526e22625ad595874f15ea98a3d89a3cb59c388d53d"

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
