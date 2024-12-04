class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.10.tar.gz"
  sha256 "ccc4c70599176ba7f0d4aabe1fed4930542a27364dffcff56b15b4d90bc8a106"
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
