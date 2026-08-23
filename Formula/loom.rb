class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.7.0"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "3a9ca715144365387ea20a1abf2d11466d78047d76e99f24df8911d09943826d"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.7.0"
    sha256 cellar: :any, arm64_tahoe: "REPLACE_WITH_ARM64_TAHOE_SHA"
    sha256 cellar: :any, tahoe:        "REPLACE_WITH_TAHOE_SHA"
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
