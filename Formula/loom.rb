class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.7.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.7.2"
    sha256 cellar: :any, arm64_tahoe: "491b7dc7ffb3b009b3ce81b0b7bb5b451f87bf6a50135abce0f78961bb574259"
    sha256 cellar: :any, tahoe:        "c7317c29f6c4ab81ee9680f6568187733fef5c80ef3b6f8b01f6b5745e656adb"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "false"
  end
end
