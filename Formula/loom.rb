class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.12.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.12.1.tar.gz"
  sha256 "e4525d09e842d47cf6d3efad694baf81a05a28c618e6790b7197958b5b11a7bb"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.12.1-bottles"
    sha256 cellar: :any, arm64_sonoma: "b57bf3e82a72d9ab76af8dae57784f94bff152a534c57df7da1a8762c76b0924"
    sha256 cellar: :any, sonoma: "07aeafdef72930e51339e688ad906dbf60e741c8f160d879cd4a12afb2b16022"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "120f09e7e1e58137e38c11e85ff174d3c1ffb0aa2f04cb427d5beb49d6fca429"

  end

  depends_on "rust" => :build

  def install
    bin.install "bin/loom"
    bin.install "bin/loomd"
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
