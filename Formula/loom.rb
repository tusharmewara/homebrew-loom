class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.8.0"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "885c91b6dd061f5ec3f17d1d96e7fc26a64ef01af0819eea11815847b174d6fd"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.8.0"
    sha256 cellar: :any, arm64_tahoe: "5bdddc0f3263be7ecffa6f5eb56bb7658457fbec25dba7bce14741a515dedf13"
    sha256 cellar: :any, tahoe: "239d16de0df9ad5cb105a7c48e1feab088069a95013148525bb99c0102f15a02"
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
