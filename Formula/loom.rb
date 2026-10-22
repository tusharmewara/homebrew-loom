class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.10.0"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "05907f187ceca1047807cee369587418e527a0fefebf6b022177b0d759681075"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.10.0-bottles"
    sha256 cellar: :any, arm64_sonoma: "2a6af889a40a516f82435e3a6e14c83bdff23d64ffc2ffc4ec39ae7ad47df77f"
    sha256 cellar: :any, sonoma: "6c8287c2223afbf4dada38f82f4d6545923bf61e956a6adcc2510f7f62c3441b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ffb8de3258b469dcbaf0bf29f8ffad404b25ecca465f4b6778fc16d74d26a3a2"

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
