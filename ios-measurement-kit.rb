class IosMeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.8"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.8.tar.gz"
  sha256 "773c0f03fa21b56b34a24f97b4fedf96e66b0f49ef549d5c674e63ed43e1c278"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "c7608d384a1d56f2f9dbd210763d98e6457ac3eabafb0675089c5b13e4bf7186" => :mojave
  end

  depends_on "ios-libevent"
  depends_on "ios-libmaxminddb"
  depends_on "ios-curl"

  depends_on "git" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "cross" => :build

  keg_only "this is an iOS build that we should not install system wide"

  def install
    system "./autogen.sh", "-n"
    [ "i386", "x86_64", "armv7s", "arm64" ].each do |arch|
      mkdir "build-#{arch}" do
        system "cross-ios", "#{arch}", "../configure", "--prefix=#{prefix}/#{arch}",
                            "--disable-shared",
                            "--disable-dependency-tracking",
                            "--with-libevent=/usr/local/opt/ios-libevent/#{arch}",
                            "--with-openssl=/usr/local/opt/ios-libressl/#{arch}",
                            "--with-libcurl=/usr/local/opt/ios-curl/#{arch}",
                            "--with-libmaxminddb=/usr/local/opt/ios-libmaxminddb/#{arch}"
        system "make", "V=0", "install"
      end
    end
  end
end
