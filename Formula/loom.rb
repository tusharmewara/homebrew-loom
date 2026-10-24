class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.10.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "5349edd073ff627337899c2ae7078a7e7642fbbca6c14d4b21d6f5e5ad7cd488"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.10.1-bottles"
    sha256 cellar: :any, arm64_sonoma: "d6d32a42ff83618b34280f57a86e6b7ba17408a19f98ef04c550463e019655b0"
    sha256 cellar: :any, sonoma: "56feb1fc14b47400644379dd79c18bd30f2f38512f83de28f15837a5c6ac042a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9c4b23fbe82acdf8a6462c3f6521e2dd16356dafafe4ae335dc7f75423615295"

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
