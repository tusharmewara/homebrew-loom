class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.8.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "7695e6fbbbf453b20e37fe4585a2684c79a8caf82d040862330b73d46d5f8d66"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.8.2"
    sha256 cellar: :any, arm64_tahoe: "da5bc484a7ac8c296cc70d2dbf9aa829d0161cd64fe78a06c0678f9ef05ecc73"
    sha256 cellar: :any, tahoe: "da5bc484a7ac8c296cc70d2dbf9aa829d0161cd64fe78a06c0678f9ef05ecc73"
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
