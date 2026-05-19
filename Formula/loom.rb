class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  url "https://github.com/tusharmewara/loom/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  depends_on "rust" => :build if build.from_source?

  # Bottle for macOS ARM64 and Intel
  bottle do
    root_url "https://github.com/tusharmewara/loom/releases/download/v2.0.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0000000000000000000000000000000000000000000000000000000000000000"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "0000000000000000000000000000000000000000000000000000000000000000"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0000000000000000000000000000000000000000000000000000000000000000"
    sha256 cellar: :any_skip_relocation, monterey: "0000000000000000000000000000000000000000000000000000000000000000"
    sha256 cellar: :any_skip_relocation, ventura: "0000000000000000000000000000000000000000000000000000000000000000"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0000000000000000000000000000000000000000000000000000000000000000"
  end

  def install
    if build.from_source?
      # Build both binaries together for speed
      system "cargo", "build", "--release", "--bins", "-p", "loom-cli", "-p", "loomd"
      bin.install "target/release/loom"
      bin.install "target/release/loomd"
    else
      bin.install "loom"
      bin.install "loomd"
    end
  end

  def post_install
    agents_dir = Dir.home/".agents"
    agents_dir.mkpath unless agents_dir.exist?
  end

  service do
    run opt_bin/"loomd"
    keep_alive true
    working_dir Dir.home/".agents"
    log_path var/"log/loomd.log"
    error_log_path var/"log/loomd.err.log"
  end

  test do
    assert_match "Loom CLI v2.0.0", shell_output("#{bin}/loom --version")
    assert_match "Loom Daemon", shell_output("#{bin}/loomd --version")
  end
end
