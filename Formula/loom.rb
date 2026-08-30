class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.7.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.7.1"
    sha256 cellar: :any, arm64_tahoe: "5ff152a27afd4fd8c000c950f736780e1102da72d4d801466f742a35f14369f0"
    sha256 cellar: :any, tahoe:        "34398dd665d33844e07944470fe9a57430897b51df86506454d2d8660037738a"
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
