class AndroidMeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.7"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.7.tar.gz"
  sha256 "abe8f2f24ed64c0fed9b439cb7f335456f11ac204a8d679c31595cdec87c6b7b"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "7f1b58fd1a2d692d437baf1e487fb02e9445136643a0d0b33d94a726a9ec8a9a" => :mojave
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
