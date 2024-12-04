class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.9.99.tar.gz"
  sha256 "d05116e67d9cd36d728873f8171693bfa4a137e3345c9d0ca2da1670dfafcf3e"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"

    heulpad_dir = Pathname.new(File.join(Dir.home, ".heulpad"))
    heulpad_dir.mkpath
    system "chmod", "700", heulpad_dir.to_s
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
