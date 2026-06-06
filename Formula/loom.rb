class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.5"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.5.tar.gz"
  sha256 "fabee1c332a8ef991839bf043215db734e45f172251de8dbda9504e3802e3277"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.5"
    sha256 cellar: :any, arm64_tahoe: "66aba6c04b8a912eda6f98882e291f1c67a82bb1211541e264df23d623020961"
    sha256 cellar: :any, tahoe:       "30b1ff50acf255a48d8fb7c9e59d1049a7cdf5a262c0187ccd40396cfe74e68e"
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
