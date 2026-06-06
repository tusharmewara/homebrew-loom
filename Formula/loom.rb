class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.8"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.8.tar.gz"
  sha256 "e1d6c0070d49f67062ceacfd241c6640db51d3a230c6d4d2a9404cae70394411"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.8"
    sha256 cellar: :any, arm64_sonoma: "edabf396d9f90affe191dd66acd815742d04c51e1d30b90bb559691f57eb4c40"
    sha256 cellar: :any, ventura:      "d133e880f3e84fc029e42991a9b9fed8c99b449b367fd894686d9ba98380b452"
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
