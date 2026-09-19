class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.8.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.8.2"
    sha256 cellar: :any, arm64_sonoma => "7c19a78e0b87252f73e874a53c22a0cec085775e850f7905f8e007a06d4dcbae"
    sha256 cellar: :any, sonoma => "23557e3cb8ff5b7a6252ab696b397a2109513bbd88b69c612fef41c80c0360c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux => "97119106174f80bf07dfda16d19f7e2004bcc18c3208d432ab96b87662a8c145"

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
