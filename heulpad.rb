class Heulpad < Formula
  desc "Your CLI tool description here"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.1.4.tar.gz"
  sha256 "c95721174014444624b38db869e479c2de6dcc5d9ec4bf20895a54f28ae70184"
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
