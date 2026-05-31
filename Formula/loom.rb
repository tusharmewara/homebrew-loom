class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "0a160191cec08c58e29ab519de6d40a38b54e94bdbfbf40bd8f22513b7ddc0da"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.2"
    sha256 cellar: :any, arm64_tahoe: "a1d5e944238eb60f20372a3503ec2cf61659caee2f63ecb6c1172fbcfe3ffa5d"
    sha256 cellar: :any, tahoe:       "609f0b4899b23d96d080c287ef92a4d7bd202998a11d5a30a06642a36c09a4af"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/loom-cli")
    system "cargo", "install", *std_cargo_args(path: "crates/loomd")
  end

  service do
    run [opt_bin/"loomd"]
    working_dir Dir.home
    keep_alive true
  end

  test do
    assert_match "Loom", shell_output("\#{bin}/loom --help")
  end
end
