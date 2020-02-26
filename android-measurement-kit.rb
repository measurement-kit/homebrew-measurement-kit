class AndroidMeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.11"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.11.tar.gz"
  sha256 "f9dbf5f721516fd709c13ac5011737b3622076299e3c899a1f70861901ec1b40"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "075d6b12aa115fdff7bccaba656c18aafe80aa96960b7385c2147cc78e402a50" => :catalina
  end

  depends_on "android-libevent"
  depends_on "android-libmaxminddb"
  depends_on "android-curl"

  depends_on "git" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "cross" => :build

  keg_only "this is an Android build that we should not install system wide"

  def install
    ENV['ANDROID_NDK_ROOT'] = '/usr/local/share/android-sdk/ndk-bundle'
    system "./autogen.sh", "-n"
    # We want to smoke test the MK executable on device. So, let's force
    # static linking so we don't need to copy over libc++_shared.so.
    ENV['LDFLAGS'] = "-static-libstdc++"
    [ "x86", "x86_64", "armeabi-v7a", "arm64-v8a" ].each do |arch|
      mkdir "build-#{arch}" do
        system "cross-android", "#{arch}", "../configure", "--prefix=#{prefix}/#{arch}",
                            "--disable-shared",
                            "--disable-dependency-tracking",
                            "--with-libevent=/usr/local/opt/android-libevent/#{arch}",
                            "--with-openssl=/usr/local/opt/android-libressl/#{arch}",
                            "--with-libcurl=/usr/local/opt/android-curl/#{arch}",
                            "--with-libmaxminddb=/usr/local/opt/android-libmaxminddb/#{arch}"
        system "make", "V=0", "install"
      end
    end
  end
end
