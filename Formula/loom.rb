class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.7"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.7.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.7"
    sha256 cellar: :any, arm64_tahoe: "65d5358898c1b44f597ba48529bb7266712442d0dc1b29cb5cad53ffc086808a"
    sha256 cellar: :any, tahoe:       "b78e2e425e5732eb75f00b83612939faeddcda85e1940ffbeb2e32d1ba168fd0"
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
