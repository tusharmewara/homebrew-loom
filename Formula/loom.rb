class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.9.tar.gz"
  version "0.3.9"
  sha256 "95b6d4affe842b0f272057d511f4b3733d36f4ed768a9d7e43b9e3c292f480a3"
  license "MIT"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.9"
    sha256 cellar: :any, arm64_tahoe: "206ec611464ebf12e434068645f87140e84b2c274d9fc158afb608151d2a0e45"
    sha256 cellar: :any, tahoe:       "911c726724337d86588cccd5aa88be927f5fe2fa93a559dfb755adc3e315aa31"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/loom-cli")
    system "cargo", "install", *std_cargo_args(path: "crates/loomd")
    man1.install "manpages/loom.1"
    man1.install "manpages/loomd.1"
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
