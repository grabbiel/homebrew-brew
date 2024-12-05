class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "406902f471d5c6ac3950c62f5a9d15e226b7a9f12c40e3e0f0e01b9084e77d3b"
  license "MIT"

  uses_from_macos "curl"
  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"

    mv bin/"heulpad", bin/"heulpad.real"

    (etc/"heulpad").mkpath
    (var/"heulpad/plugins").mkpath

    (bin/"heulpad").write_env_script bin/"heulpad.real",
      HEULPAD_CONFIG: "#{etc}/heulpad/config",
      HEULPAD_PLUGINS: "{#var}/heulpad/plugins"
      
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
      Configuration: #{etc}/heulpad/config
      Plugins: #{var}/heulpad/plugins
    EOS
  end

  test do
    system "#{bin}/heulpad", "--version"
    assert_predicate etc/"heulpad/config", :exist?
    assert_predicate var/"heulpad/plugins", :directory?
  end
end
