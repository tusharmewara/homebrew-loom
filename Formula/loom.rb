class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.2.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.2.1"
    sha256 cellar: :any, arm64_tahoe: "21a0963a79fa402c0fa26384e1313de9a87bbae03dcb34a87e298c45d7d1f260"
    sha256 cellar: :any, tahoe:       "fcb7af3979f7e869ba9a932374f89d5ab7e99c87f48119a6bdfff4ad56ec2ba7"
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
