class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.1.7.tar.gz"
  sha256 "3e997b0c52a685475e3ef1ea3c7a1cb0da3f15c5569fd7431a1b683316be7401"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"

    (Dir.home/".heulpad").mkpath
  end

  def post_install
    system "chmod", "700", File.expand_path("~/.heulpad")
  end

  def caveats
    <<~EOS
      User configuration datat is stored in ~/.heulpad
      
      To completely remove all data after uninstalling:
        rm -rf ~/.heulpad
    EOS
  end

  test do
    system "#{bin}/heulpad", "--version"
    assert_predicate Dir.home/".heulpad", :directory?
  end
end
