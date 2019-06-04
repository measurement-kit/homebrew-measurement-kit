class AndroidLibevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.10-stable.tar.gz"
  sha256 "52c9db0bc5b148f146192aa517db0762b2a5b3060ccc63b2c470982ec72b9a79"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "639fed9d745f24ab65b36f39a0f879c77a95ce596d8e1adca6cb0b507f5ee790" => :mojave
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "cross" => :build
  depends_on "android-libressl"

  keg_only "Android build that we should not install system wide"

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
