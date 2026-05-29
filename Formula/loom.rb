class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.3"
  license "MIT"

  url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.3/loom-0.1.3.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.3"
    sha256 cellar: :any, sonoma: "b8bff9cc6630df4441cf59c16f93600e4ed33be2d46a2d3a3c1317a1ef1827da"
    sha256 cellar: :any, ventura: "a876d153bdb7cfff3c92d402f2d82ead9dda5d870a2ce2857f7cb01ec89590bc"
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
