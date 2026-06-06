class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.6"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.6.tar.gz"
  sha256 "31defbc46ad1858864c15e1dfad10ec13178d0a73b4102b1c4f6de480acd76c5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.6"
    sha256 cellar: :any, arm64_tahoe: "edeca435feb2a0ba3d40232eefeb33ec149967708b1ce52c1f9c36b76e292ef2"
    sha256 cellar: :any, tahoe:       "84b3c250aca82a8f8173cab73f7386e318c571fe3f24f07234838625a20a742f"
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
