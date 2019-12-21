class IosMeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.7"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.7.tar.gz"
  sha256 "abe8f2f24ed64c0fed9b439cb7f335456f11ac204a8d679c31595cdec87c6b7b"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "513f0f519d4ab2d455da2638b79e186124025286903cd53f3e536debe7a8c9ec" => :mojave
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
