class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.3"
  license "MIT"

  url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.3/loom-0.1.3.tar.gz"
  sha256 "f8a4abec7ac28df0f82e7718a43d4b1631c48cb02e9a1df23aeea9e25143e8bd"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.3"
    sha256 cellar: :any, arm64_sonoma: "5674429fe4100e19b16791ca942d4b13df271ebde909bd6485f3f42f86284221"
    sha256 cellar: :any, sonoma:       "93c8ca3b9395b83c2898eeb92eab108d6a25a509a4d0f96ce0429f863897b31f"
    sha256 cellar: :any, ventura:      "ac0280ec441acaef2263591843719a8881485f639b33bb00041a8f96971c41bb"
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
