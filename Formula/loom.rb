class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.0"
  license "MIT"

  on_arm do
    url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.0/loom--0.1.0--arm64_sonoma.tar.gz"
    sha256 "a91f3d749f269181794a7b593713d8cc1c703d1347c418ece3c33379234b9822"
  end

  on_intel do
    url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.0/loom--0.1.0--monterey.tar.gz"
    sha256 "c43670427f94397f045ad1a974fbe0564c782daf0545df91d5ee6619fa09305e"
  end

  def install
    bin.install "bin/loom"
    bin.install "bin/loomd"
  end

  def post_install
    # Ensure the default loom directory exists
    loom_dir = HOMEBREW_PREFIX/".loom"
    loom_dir.mkpath unless loom_dir.exist?
  end

  service do
    run [opt_bin/"loomd"]
    keep_alive true
    log_path var/"log/loomd.log"
    error_log_path var/"log/loomd.err.log"
  end

  test do
    assert_match "Loom", shell_output("#{bin}/loom --help")
  end
end
