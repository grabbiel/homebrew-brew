class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.idk.tar.gz"
  sha256 "b0170ed3f26f98f5d11d268d34a0d23e4ed26753a8274bbe327f2c9e679b1f94"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"
  end

  def post_install
    Pathname.new(File.join(Dir.home, ".heulpad")).mkpath
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
