class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.15.tar.gz"
  sha256 "b0dab0e13ce754256cbe7df65596d6b1706ddb37b0abb86a446c6a4e2a5cb2a6"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"

    (etc/"heulpad").mkpath
    unless (etc/"heulpad/config").exist?
      (etc/"heulpad/config").write <<~EOS
        [settings]
        default_folder=/tmp
        auto_backup=true
      EOS
    end
    
  end

  def caveats
    <<~EOS
      Configuration files are installed to:
      #{etc}/heulpad/config
    EOS
  end

  test do
    system "#{bin}/heulpad", "--version"
assert_predicate etc/"heulpad/config", :exist?
  end
end
