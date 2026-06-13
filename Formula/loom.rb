class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.6.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "3f965236f96e5dd065303e70b84a5505bc973f5030aca4086c6f49133ed664a4"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.6.1"
    sha256 cellar: :any, arm64_tahoe: "0da72a9881deebd1c0a2732255289352c266619c0a521dcbea2530f3e2334b90"
    sha256 cellar: :any, tahoe:        "1547b02536d1cdf32b746656fb30a63c5b0612b1def22245f376eb610f624e06"
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
