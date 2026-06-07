class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.3.10"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.3.10.tar.gz"
  sha256 "83ea365c9222c699a3866cf897be57dbea7a768060e2c01eb2cfb9021576b14c"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.3.10"
    sha256 cellar: :any, arm64_tahoe: "53526801a0ec8fca61941ace03546afb62c737cd09ba29510c5dde8c2b6abafd"
    sha256 cellar: :any, tahoe:        "1473c0247b84ad3d6b16ef2382f16e57730e73d8bcb9ed4ca698550e79c9af2a"
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
