class Heulpad < Formula
  desc "Your CLI tool description here"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.1.5.tar.gz"
  sha256 "3f83680a42737fa80a6b46f9c830c6f0dc73681fd5188b5385d63a090b9a9046"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"
  end

  test do
    system "#{bin}/heulpad", "--version"
  end
end
