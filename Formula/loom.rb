class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.1.3"
  license "MIT"

  url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.3/loom-0.1.3.tar.gz"
  sha256 "f8a4abec7ac28df0f82e7718a43d4b1631c48cb02e9a1df23aeea9e25143e8bd"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.1.3"
    sha256 cellar: :any, sonoma:  "416d9c8299fcde46fe3265e1950e3263dce3280c3e26aaaaaaa0d3539848052c"
    sha256 cellar: :any, ventura: "e25917f4883787306c3e474afe808074afbddcea06d223fb52a77787a2b3b5d1"
  end

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
