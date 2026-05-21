class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.0"
  license "MIT"

  on_arm do
    url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.0/loom--0.1.0--arm64_sonoma.tar.gz"
    sha256 "cab71ef57be953b91bc0c5a3a0fcd2903196bf868e49ae599f3b68e1594f3b8e"
  end

  on_intel do
    url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.0/loom--0.1.0--monterey.tar.gz"
    sha256 "ad3af84504e2a7562e01e9641f0aae593ddfbe46eda9b188130c23ce32638722"
  end

  def install
    bin.install "bin/loom"
    bin.install "bin/loomd"
  end

  def post_install
    # ~/.loom is created by loomd on first run
    # Users can run 'loom init' and 'loom scan' manually if needed
  end

  service do
    run [opt_bin/"loomd"]
    working_dir Dir.home
    keep_alive true
    log_path var/"log/loomd.log"
    error_log_path var/"log/loomd.err.log"
  end

  test do
    assert_match "Loom", shell_output("#{bin}/loom --help")
  end
end
