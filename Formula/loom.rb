class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "2.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v2.1.tar.gz"
  sha256 "9649db2c11e0bae033cc2c6accb9af3c7a23cc17c4fd1204699c2b7efd4b7560"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v2.1"
    sha256 cellar: :any, tahoe:      "fcb7af3979f7e869ba9a932374f89d5ab7e99c87f48119a6bdfff4ad56ec2ba7"
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
