class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.9.1"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.9.1"
    sha256 cellar: :any, arm64_sonoma: "358c43bebf087789c357356c297e21339dbe91d61939fee2e90f71b575c7541f"
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
