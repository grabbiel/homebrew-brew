class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.1.8.tar.gz"
  sha256 "44627741ddafc98e4597fe3dd849390f8606000226f52f912583c740220844ce"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"

    (File.join(Dir.home, ".heulpad")).mkpath
  end

  def post_install
    system "chmod", "700", File.expand_path("~/.heulpad")
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
    assert_predicate File.join(Dir.home, ".heulpad"), :directory?
  end
end
