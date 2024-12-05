class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "a4eeedb62bd4c65a361247a0bd247b3fe329e47074237e1cb38b4189a36bcb7a"
  license "MIT"

  uses_from_macos "curl"
  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/heulpad"

    mv bin/"heulpad", bin/"heulpad.real"

    # Create directories
    (etc/"heulpad").mkpath
    (var/"heulpad/plugins").mkpath
    (share/"heulpad").mkpath

    # Create plugins registry file
    (share/"heulpad/plugins.list").write <<~EOS
      cloud
    EOS

    # Create wrapper with environment variables 
    (bin/"heulpad").write_env_script bin/"heulpad.real",
      HEULPAD_CONFIG: "#{etc}/heulpad/config",
      HEULPAD_PLUGINS: "#{var}/heulpad/plugins"
      HEULPAD_PLUGINS_REGISTRY: "#{share}/heulpad/plugins.list"
     
    # Create default config
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
      Plugins Registry: #{share}/heulpad/plugins.list
    EOS
  end

  test do
    system "#{bin}/heulpad", "--version"
    assert_predicate etc/"heulpad/config", :exist?
    assert_predicate var/"heulpad/plugins", :directory?
    assert_predicate share/"heulpad/plugins.list", :exist?
  end
end
