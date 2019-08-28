class IosMeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.6"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.6.tar.gz"
  sha256 "5ec94e522c3bc43cbf749659c18d4b13bcfbb2874db4d6b4e21b160d76dd5bd0"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "96733960072822b114c1dce4f49feb80c271651583c8e5e4ad5401d88ef99ae7" => :mojave
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
