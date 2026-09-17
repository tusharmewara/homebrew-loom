class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.8.0"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "885c91b6dd061f5ec3f17d1d96e7fc26a64ef01af0819eea11815847b174d6fd"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.8.0"
    sha256 cellar: :any, arm64_tahoe: "212e5650b3aadd8fc443f846d46f45da245c1a422f2c129937f46c3da7cff493"
    sha256 cellar: :any, tahoe: "2493bd06db348372d1ea49c4580237eef4584260894c057705c06b8685796584"
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
