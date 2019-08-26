class AndroidLibevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.11-stable.tar.gz"
  sha256 "229393ab2bf0dc94694f21836846b424f3532585bac3468738b7bf752c03901e"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "6ba117b73fcb532d08eed5378c31894792a6d6832559ef8465546350a734966f" => :mojave
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
