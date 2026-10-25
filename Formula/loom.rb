class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.10.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.10.2.tar.gz"
  sha256 "2aaa10479cde20fd2695d6c06d9377229c4e2657a81acc9a1dd8640da647e1aa"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.10.2-bottles"
    sha256 cellar: :any, arm64_sonoma: "2c2dd4582c5d28cda60c1c7dd92bb611ee07fdda8e3c32eba5fd0884c037cad2"
    sha256 cellar: :any, sonoma: "86473c3a4b0591d282e2a6900de09088e4571200cd3fd86465ce8715b4d39d9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "74dd4b3f703f3011fb84b91d3b1d6cdae576218823a8dd2c401a0361ddad2e0a"

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
