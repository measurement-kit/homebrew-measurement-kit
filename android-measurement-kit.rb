class AndroidMeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.4"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.4.tar.gz"
  sha256 "6ca0d9e7a9c1ff0ea8713bf59fde9f87365acdc4b784a5a4bb3f35a77bc4b775"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "c83857dddfefba232c90ea02be7a92b5f160488984269d53881ef45a962c468e" => :mojave
  end

  depends_on "android-libevent"
  depends_on "android-libmaxminddb"
  depends_on "android-curl"

  depends_on "git" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "cross" => :build

  keg_only "Android build that we should not install system wide"

  def install
    ENV['ANDROID_NDK_ROOT'] = '/usr/local/share/android-sdk/ndk-bundle'
    system "./autogen.sh", "-n"
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
