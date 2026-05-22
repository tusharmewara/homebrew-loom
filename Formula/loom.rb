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
    sha256 cellar: :any, arm64_sonoma:  "e25af14867bb22466163cd48e2bee8bc5d3ed2e36c320e8187f47026c028a6bc"
    sha256 cellar: :any, ventura:       "675b320eaf9453005fe8bcf0324b030c7d7e7b644dda1dc32bcf563d85f42a88"
    sha256 cellar: :any, monterey:      "120f9f8a544c3b178340a6779212ddaf99b533ede8034d281b9b623ae18fa614"
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
