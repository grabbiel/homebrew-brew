class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.1.6.tar.gz"
  sha256 "862e1bac67ff4999cf00990ba7ff6039a9651d787b819ffd8a68e17a06a8de67"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"
  end

  test do
    system "#{bin}/heulpad", "--version"
  end
end
