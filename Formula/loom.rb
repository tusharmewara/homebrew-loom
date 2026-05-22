class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.2"
    sha256 cellar: :any, ventura:       "e94aa9f8066a6ff3972db4763ce75a8b59f633b4cb07cc3770ddffef63bf0440"
    sha256 cellar: :any, x86_64_linux:   "e94aa9f8066a6ff3972db4763ce75a8b59f633b4cb07cc3770ddffef63bf0440"
  end

  def install
    bin.install "bin/loom"
    bin.install "bin/loomd"
  end

  def post_install
    # ~/.loom is created by loomd on first run
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
