class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.0"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.0"
    sha256 cellar: :any, arm64_tahoe: "0da65ffc31c39f7b4229f0ade54dab1eb08b5d7d586feb0ce896c0f85074c485"
    sha256 cellar: :any, tahoe:       "014ca24c90151686abef5cf96f2d26ee14814b849814a8f483ef81c314cfaeb8"
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
