class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.8.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.8.2"
    sha256 cellar: :any, arm64_sonoma: "c3db56c58dda8798b3f64402119b4ad0499d9da1606d6dd47a32df0640d0addd"
    sha256 cellar: :any, sonoma: "c82a345a4644e79ac75b86ba0337b65b5049b811e3d44d686b4d8196e3c0d5aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "094e1193bac1f6201e26302ebfa3e5a6937db5e9a8854894a88ccde0840707ed"

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
