class AndroidLibevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.12-stable.tar.gz"
  sha256 "7180a979aaa7000e1264da484f712d403fcf7679b1e9212c4e3d09f5c93efc24"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "83355fc8b963d943015527fc8cba598a1a8784c1850967ac5460c2f1b6ae5c98" => :catalina
  end

  depends_on "android-libressl"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cross" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  keg_only "this is an Android build that we should not install system wide"

  def install
    ENV['ANDROID_NDK_ROOT'] = '/usr/local/share/android-sdk/ndk-bundle'
    system "./autogen.sh"
    [ "x86", "x86_64", "armeabi-v7a", "arm64-v8a" ].each do |arch|
      mkdir "build-#{arch}" do
        ENV["CPPFLAGS"] = "-I/usr/local/opt/android-libressl/#{arch}/include"
        ENV["LDFLAGS"] = "-L/usr/local/opt/android-libressl/#{arch}/lib"
        system "cross-android", "#{arch}", "../configure",
                            "--disable-dependency-tracking",
                            "--disable-debug-mode",
                            "--disable-shared",
                            "--disable-samples",
                            "--disable-libevent-regress",
                            "--prefix=#{prefix}/#{arch}"
        system "make", "install"
      end
    end
  end
end
