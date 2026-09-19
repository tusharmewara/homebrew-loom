class Loom < Formula
  desc "Unified agentic ecosystem for sharing skills, sessions, and MCP servers"
  homepage "https://github.com/tusharmewara/loom"
  version "0.8.2"
  license "MIT"

  url "https://github.com/tusharmewara/loom/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  bottle do
    root_url "https://github.com/tusharmewara/homebrew-loom/releases/download/v0.8.2"
    sha256 cellar: :any, 8.2.arm64_sonoma => "d5591fa70c55b1abbdc1dc90e5796bef29f7a7af4b0537acaeae4f3389d8fa53"
    sha256 cellar: :any, 8.2.sonoma => "15ca53af53bbe6b177ed61e0a90c4e9d0c7a94955af22b369561d21779dec3c2"
    sha256 cellar: :any, 8.2.x86_64_linux => "f84f7e52c32e719026f7aa3e2206881ff4e09d8d76fb3d9c016093fa5a5edcb0"

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
