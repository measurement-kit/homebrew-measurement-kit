class IosMeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.5"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.5.tar.gz"
  sha256 "8b83f04f4d3c653f93bcee5a6cc5e32e6595a3feb99526017d78099fd90d4a75"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "9b271e18730db5ff8de960e9dec68378017b37509ef6e8f6f7ef54bfee367df8" => :mojave
  end

  depends_on "ios-libevent"
  depends_on "ios-libmaxminddb"
  depends_on "ios-curl"

  depends_on "git" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "cross" => :build

  keg_only "iOS build that we should not install system wide"

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
