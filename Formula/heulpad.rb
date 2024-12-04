class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.9.2.tar.gz"
  sha256 "99be96548228371a2de7a3cf4adbe411af6315ea3ba419eff8ada2069ab30e50"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"

    Pathname.new(File.join(Dir.home, ".heulpad")).mkpath
  end

  def post_install
    system "chmod", "700", File.join(Dir.home, ".heulpad")
  end

  def caveats
    <<~EOS
      User configuration data is stored in ~/.heulpad
      
      To completely remove all data after uninstalling:
        rm -rf ~/.heulpad
    EOS
  end

  test do
    system "#{bin}/heulpad", "--version"
    assert_predicate Pathname.new(File.join(Dir.home, ".heulpad")), :directory?
  end
end
