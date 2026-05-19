class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/yourusername/loom"
  url "https://github.com/yourusername/loom/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"

  depends_on "rust" => :build
  depends_on "pkg-config" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "loom-cli")
    system "cargo", "install", *std_cargo_args(path: "loomd")
  end

  def post_install
    # Ensure the default agents directory exists
    agents_dir = HOMEPATH/".loom"
    agents_dir.mkpath unless agents_dir.exist?
  end

  service do
    run opt_bin/"loomd"
    keep_alive true
    working_dir HOMEPATH/".loom"
    log_path var/"log/loomd.log"
    error_log_path var/"log/loomd.err.log"
  end

  test do
    assert_match "Loom CLI", shell_output("#{bin}/loom --help")
  end
end