class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.9.6"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.9.6.tar.gz"
  sha256 "a60b0d4a748aeff6c19dc289e8c5da246be619e9ec32cf153a90dcd33c8a0f70"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.9.6-bottles"
    sha256 cellar: :any, arm64_sonoma: "3af66e1df8a24ac97451f0f549e60bd503d6f596daa22af2665231d3bd34271b"
    sha256 cellar: :any, sonoma: "14deaacb4fd32e6d7f931db192524e6e1ec8547c5bdf85cf28055ef727c1723c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7ba2993beafa43cad4bb8e571536cb6ff07b3684b5c7611941a656013011b5fd"

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
