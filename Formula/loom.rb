class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.0"
  license "MIT"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v#{version}"
    rebuild 1
    sha256 cellar: :any, arm64_sequoia: "a91f3d749f269181794a7b593713d8cc1c703d1347c418ece3c33379234b9822"
    sha256 cellar: :any, arm64_sonoma:  "b84b9bb7b8424df3164c30aa21cae74092a873d67d893ac84cb4826dcc6a77f9"
    sha256 cellar: :any, ventura:       "c43670427f94397f045ad1a974fbe0564c782daf0545df91d5ee6619fa09305e"
    sha256 cellar: :any, monterey:      "39a93a2c778cd78addfb4cfdce1e0191db915f9a574ee12a973e38b373902c5a"
  end

  def install
    bin.install "bin/loom"
    bin.install "bin/loomd"
  end

  def post_install
    # ~/.loom is created by loomd on first run
    # Users can run 'loom init' and 'loom scan' manually if needed
  end

  service do
    run [opt_bin/"loomd"]
    working_dir Dir.home
    keep_alive true
    log_path var/"log/loomd.log"
    error_log_path var/"log/loomd.err.log"
  end

  test do
    assert_match "Loom", shell_output("#{bin}/loom --help")
  end
end
