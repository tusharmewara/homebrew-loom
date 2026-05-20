class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.0"
  license "MIT"

  on_arm do
    url "https://github.com/tusharmewara/loom/releases/download/v0.1.0/loom--0.1.0--arm64_sonoma.tar.gz"
    sha256 "69ded4d3cf7fc0ff52a293bcdc41d9794e4052eee25a0775c45ce98325aba341"
  end

  on_intel do
    url "https://github.com/tusharmewara/loom/releases/download/v0.1.0/loom--0.1.0--monterey.tar.gz"
    sha256 "583ffab430637bd486c266cb630cb02457a90becce0cbe950aefb1ad9605ea36"
  end

  def install
    bin.install "bin/loom"
    bin.install "bin/loomd"
  end

  def post_install
    # Ensure the default loom directory exists
    loom_dir = HOMEBREW_PREFIX/".loom"
    loom_dir.mkpath unless loom_dir.exist?
  end

  service do
    run [opt_bin/"loomd"]
    keep_alive true
    log_path var/"log/loomd.log"
    error_log_path var/"log/loomd.err.log"
  end

  test do
    assert_match "Loom", shell_output("#{bin}/loom --help")
  end
end
