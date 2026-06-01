class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.3"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "d6550fab71d9c4f75a20b159c575db2b1eadd1d2a6b5861af189b015041ab881"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.3"
    sha256 cellar: :any, arm64_tahoe: "e57e6dd20d566f437f6813dffe1ec25cfbe559014d65a60afbdffa2f09dad921"
    sha256 cellar: :any, tahoe:       "d01c4b62c8ff3db10bfc044fd7f3e6bf14187288199854f78bfc5a2f8879ec4a"
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
    assert_match "Loom", shell_output("\#{bin}/loom --help")
  end
end
