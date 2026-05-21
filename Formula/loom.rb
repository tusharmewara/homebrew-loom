class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.0"
  license "MIT"

  on_arm do
    url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.0/loom--0.1.0--arm64_sonoma.tar.gz"
    sha256 "8f48eb4a9825c1dc44142d97eb1489feb6cbeab1823d8c1479fa5da6f2166e2f"
  end

  on_intel do
    url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.0/loom--0.1.0--monterey.tar.gz"
    sha256 "47fae7d7e3d9bd71d599e96e724ecb6e82c3ac3445fcde2a128bee58728bf894"
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
