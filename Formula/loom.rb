class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  url "https://github.com/tusharmewara/loom/releases/download/2.0.0/loom-2.0.0.tar.gz"
  sha256 "dc3791f7bf71af25872da2c1707e3d1563e7227552de058242d2bf238f46c7b8"
  license "MIT"

  depends_on "rust" => :build if build.from_source?

  # Bottle for macOS ARM64 and Intel
  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v2.0.0"
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
