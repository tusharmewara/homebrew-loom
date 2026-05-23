class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.2"
  license "MIT"

  # Source tarball in homebrew-loom releases
  url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.2/loom-0.1.2.tar.gz"
  sha256 "92fcd2165acc655a7b543725a89559d956799dbd030713087db55c012626836a"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.2"
    sha256 cellar: :any, ventura: "1fa611e2da8aec33fe3f4ce399baefd147830f702eebb8c8db6994019dd6a6fc"
    sha256 cellar: :any, sonoma: "b969adaf54ff028ce07c4060e0c1c5ad4df3b0d140369590fd5712f817fd55de"
  end

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
