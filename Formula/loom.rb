class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.12.0"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "cef3eaab8e464161f71baa88fbc1626b805bde1f9a4af9b274adaf8858a54c84"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.12.0-bottles"
    sha256 cellar: :any, arm64_sonoma: "7787727a13e386cb6b3b3e67e8534be09a0e78bf68b7f3f9aee72ce0f46473ad"
    sha256 cellar: :any, sonoma: "dd5767cb9b7741171481940ccad1b35fd718198da166d66ca93555e79766b2bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "db624dfacddfe942d00875238f35783838db459a54502814e4a006dd7c691ea8"

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
