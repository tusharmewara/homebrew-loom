class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.0"
  license "MIT"

  on_arm do
    url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.0/loom--0.1.0--arm64_sonoma.tar.gz"
    sha256 "8c2d40728a5d6b701b12cb3afc343bdf7c4d47fd5ac6adc3a0f89cf7c1bcef24"
  end

  on_intel do
    url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.0/loom--0.1.0--monterey.tar.gz"
    sha256 "e90af2aa45a79eadf4a6419a2e7a6a3f15ba472ef64e37f3b66b6541d3b20a63"
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
