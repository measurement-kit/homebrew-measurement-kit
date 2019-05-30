class IosMeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.4"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.4.tar.gz"
  sha256 "6ca0d9e7a9c1ff0ea8713bf59fde9f87365acdc4b784a5a4bb3f35a77bc4b775"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "d1b0da78606380eee0e33ce6c087c1177e680c68a211394fb881cd4e9d9097b2" => :mojave
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
