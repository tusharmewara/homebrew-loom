class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.11.0"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "b577b4130f5ed82ffc782282c29a2ccf9dabc9601636af1bf0db48a4cc447ab2"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.11.0-bottles"
    sha256 cellar: :any, arm64_sonoma: "20545c38aaf5af795a1d1108f02f489a8240f5bb191275710d3a6944118b95ac"
    sha256 cellar: :any, sonoma: "ca15ec505e2dfabae4ef642407854c0ceabf22edeb6e7f41bef0391acf12b22d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3d2c50afef7618f338ddb457e41a460657805ff257795e46f81a781deac474a7"

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
