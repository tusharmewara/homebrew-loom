class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.7"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.7.tar.gz"
  sha256 "727884b31e18d0282f844128a04f29b13343c1b5c862503abc91cc9f317d4781"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.7"
    sha256 cellar: :any, arm64_tahoe: "b66249ce840ab378c4e0f248611f422e114a748c20cd50412c088be8faac75c6"
    sha256 cellar: :any, tahoe:       "b88cd486e2548b4b7728f9b38e388abe01d5b755aadf6762a86781215e7e7d14"
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
