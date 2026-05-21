class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.2"
  license "MIT"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.2"
    rebuild 1
    sha256 cellar: :any, arm64_sequoia: "a91f3d749f269181794a7b593713d8cc1c703d1347c418ece3c33379234b9822"
    sha256 cellar: :any, arm64_sonoma:  "32d606bb856b40914acc2a773a2a4bc5e2203c31d3caf37a0af8059abdf99ea0"
    sha256 cellar: :any, ventura:       "c43670427f94397f045ad1a974fbe0564c782daf0545df91d5ee6619fa09305e"
    sha256 cellar: :any, monterey:      "624ac765a9fb4d8a71e84298f5900d36924b561c5e5c6db6cd2a6be1b4794f9f"
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
