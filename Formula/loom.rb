class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "aeca3fcbdfefe03669c9c57511b676448891de4ed5324467e55466999450ac51"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.1"
    sha256 cellar: :any, arm64_tahoe: "6f267135ddbbfb7b7cd05abb9b55a2c8e7252f88e472bdf2851e40a95d5abf37"
    sha256 cellar: :any, tahoe:       "29cc2d9a02272ff4ed2df3405a3b3f6fe6daae73b8971961baf67e9cf25201f3"
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
    assert_match "Loom", shell_output("#{bin}/loom --help")
  end
end
