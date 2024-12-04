class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.12.tar.gz"
  sha256 "db6e02d2265782a2845afee07b0218fef9d75051dcb20ccf23188f851e79b379"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"

    (pkgshare/".config").write <<~EOS
      version=0.0.1
      author=RUMPO
    EOS
    
    (pkgshare/"data").mkpath
  end

  def caveats
    <<~EOS
      Configuration files are installed to:
      #{pkgshare}
    EOS
  end

  test do
    system "#{bin}/heulpad", "--version"
assert_predicate pkgshare/".config", :exist?
  end
end
