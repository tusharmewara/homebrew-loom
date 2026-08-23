class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.7.0"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "3a9ca715144365387ea20a1abf2d11466d78047d76e99f24df8911d09943826d"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.7.0"
    sha256 cellar: :any, arm64_tahoe: "424d496d8e39ae54655dfd7096cbd207962f9a4b64dc7163fb9dc3bb866dc1a1"
    sha256 cellar: :any, tahoe:        "47c2c4ebb68290de426856684a5d93856abb71ff07b821aa49c0a853c62c31a9"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  service do
    run [opt_bin/"loomd"]
    working_dir Dir.home
    keep_alive true
  end

  test do
    assert_match "Loom", shell_output("#{bin}/loom --help")
  end
end
