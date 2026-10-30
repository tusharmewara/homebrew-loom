class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.12.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.12.1.tar.gz"
  sha256 "e4525d09e842d47cf6d3efad694baf81a05a28c618e6790b7197958b5b11a7bb"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.12.1-bottles"
    sha256 cellar: :any, arm64_sonoma: "7561e5767bc674f1b231a625a561678e4ef4e068fb015dcbd894e7c11fb02c9d"
    sha256 cellar: :any, sonoma: "a40c3e6c125554bfb9489d3032364588f597696c11642be7663995a8bb9a2661"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "374adf5c6f268f6f1c5128070360eb9ccb31c46440bf5f3a28f5a383d6dc8790"

  end

  depends_on "rust" => :build

  def install
    bin.install "bin/loom"
    bin.install "bin/loomd"
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
