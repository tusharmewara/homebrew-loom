class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.2"
    sha256 cellar: :any, arm64_sequoia: "a91f3d749f269181794a7b593713d8cc1c703d1347c418ece3c33379234b9822"
    sha256 cellar: :any, arm64_sonoma:  "cdb938b6dfc6870854e3f34601d788052bc68c15ef42a9f9fe69625e22f3bb77"
    sha256 cellar: :any, ventura:       "c43670427f94397f045ad1a974fbe0564c782daf0545df91d5ee6619fa09305e"
    sha256 cellar: :any, monterey:      "8cc29f77704d1e2c8f35f80ec91ed1f4e97c9f892ae312ebbeb23e4d172e1b51"
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
