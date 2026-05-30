class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.2.0"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.2.0"
    sha256 cellar: :any, tahoe:      "92b2b9520d744333d81704ee33c0930e5850e3816219cc31eee3f9de4add8f02"
    sha256 cellar: :any, arm64_tahoe: "785d3e6415fafa29cba8a1194cdf76d33a1af5ddbe8772924dbdfa769d447281"
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
