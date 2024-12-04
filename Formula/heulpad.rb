class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.10.1.tar.gz"
  sha256 "03a2c0febcf8a731107478791c221d1d387c44c9de0d7c4530dc9784001fd297"
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

  test do
    system "#{bin}/heulpad", "--version"
    assert_predicate Pathname.new(File.join(Dir.home, ".heulpad")), :directory?
  end
end
