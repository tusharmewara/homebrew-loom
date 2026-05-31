class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.0"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.0"
    sha256 cellar: :any, arm64_tahoe: "c3d1dc50b3cdb5c9b203cb254fdb080a6f0cad6f03999fc3fd2a23566285ce84"
    sha256 cellar: :any, tahoe:       "ad4fa4929fd41f2adb7f9f8f25205c44b10c15617926d420d110bac2a0cb716a"
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
