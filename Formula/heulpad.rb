class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.11.tar.gz"
  sha256 "7e1dfd3d11e54a9478f25731381c802994ec9a37019aa856bd14deca19353e43"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"

    home_dir = ENV["HOME"]
    heulpad_dir = "#{home_dir}/.heulpad"
    system "mkdir", "-p", heulpad_dir
    system "chmod", "700", heulpad_dir
  end

  test do
    system "#{bin}/heulpad", "--version"
    assert_predicate File.directory?(File.join(ENV["HOME"], ".heulpad"))
  end
end
