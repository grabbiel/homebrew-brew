class Heulpad < Formula
  desc "Manage content from inside the terminal"
  homepage "https://github.com/grabbiel/heulpad"
  url "https://github.com/grabbiel/heulpad/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7c5f15d08c71e829171f274a24e80632ceb372fe370e773b34baf8c9bfb91253"
  license "MIT"

  uses_from_macos "curl"
  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    
    bin.install "build/heulpad"
    libexec.install Dir["build/src/commands/**/heulpad-*"]
    man1.install Dir["man/*.1"]

    chmod 0755, Dir[libexec/"heulpad-*"]

    mv bin/"heulpad", bin/"heulpad.real"

    # Create directories
    (etc/"heulpad").mkpath
    (var/"heulpad/plugins").mkpath
    (share/"heulpad").mkpath

    # Create plugins registry file
    (share/"heulpad/plugins.list").write <<~EOS
      cloud
    EOS

    # Create Help file
    (share/"heulpad/help.txt").write <<~EOS
      enable: Enable and install plugin
      disable: Disable an installed plugin
      new: Initialize project in current directory
    EOS

    # Create wrapper with environment variables 
    (bin/"heulpad").write_env_script bin/"heulpad.real",
      HEULPAD_CONFIG: "#{etc}/heulpad/config",
      HEULPAD_PLUGINS: "#{var}/heulpad/plugins",
      HEULPAD_PLUGINS_REGISTRY: "#{share}/heulpad/plugins.list",
      HEULPAD_LIBEXEC: libexec
     
    # Create default config
    unless (etc/"heulpad/config").exist?
      (etc/"heulpad/config").write <<~EOS
        [settings]
        default_folder=/tmp
        auto_backup=true
      EOS
    end
  end

  def post_uninstall
    rm_rf var/"heulpad/plugins"
  end

  def caveats
    <<~EOS
      Configuration: #{etc}/heulpad/config
      Plugins: #{var}/heulpad/plugins
      Plugins Registry: #{share}/heulpad/plugins.list

      To completely remove all data after uninstalling:
        rm -rf #{var}/heulpad
        rm -rf #{etc}/heulpad
    EOS
  end

  test do
    system "#{bin}/heulpad", "--version"
    assert_predicate etc/"heulpad/config", :exist?
    assert_predicate var/"heulpad/plugins", :directory?
    assert_predicate share/"heulpad/plugins.list", :exist?
  end
end
