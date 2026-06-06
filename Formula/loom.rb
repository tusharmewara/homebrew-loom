class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.4"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "4dc4d1eeea7243480fcb8e91ba109ae46cc02a7e9a07e5f757cae96ef22fa7a2"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.4"
    sha256 cellar: :any, arm64_tahoe: "21d1960d43493468104e30b9bb11f5cf71e3bfa27de7351e0abd10c6a82a31db"
    sha256 cellar: :any, tahoe:       "ba7270af90207efc3f7e16a48e2022901420012d87fbdaadbe2b6124789e7a10"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/loom-cli")
    system "cargo", "install", *std_cargo_args(path: "crates/loomd")
    man1.install "manpages/loom.1"
    man1.install "manpages/loomd.1"
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
