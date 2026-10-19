class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.9.5"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.9.5.tar.gz"
  sha256 "51a50eb4c729d016f8e73dcf4fc6ce8d306a9d410736272921e0813a4959e1db"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.9.5-bottles"
    sha256 cellar: :any, arm64_sonoma: "9426b478be26e0fbea4019bf5ccab9bb1e4c6aba38aee6871f74bfc2371e53d1"
    sha256 cellar: :any, sonoma: "0279ab996f8b7bfa9f5072a1719eb385d7597e4fbb2f603d67e44636bc7e51e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4c94c389f76dd3e136176a9cc17c019318b343d869ff489b92672696b497e78d"
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
