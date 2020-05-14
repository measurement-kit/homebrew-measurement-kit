class MingwW64MeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.11"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.11.tar.gz"
  sha256 "f9dbf5f721516fd709c13ac5011737b3622076299e3c899a1f70861901ec1b40"
  revision 2

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "d369cddcd5c2495b19cecbf1b1dfbccf3d0d5aefc66c69ab0fc93b6028d03a16" => :catalina
  end

  depends_on "mingw-w64-libevent"
  depends_on "mingw-w64-libmaxminddb"

  depends_on "cross" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "git" => :build
  depends_on "libtool" => :build

  keg_only "this is a Windows build that we should not install system wide"

  def install

    ENV['CPPFLAGS'] = '-Wno-cpp'
    ENV['LDFLAGS'] = '-static'
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'

    # TODO(bassosimone): figure out why the measurement_kit binary built
    # using this procedure isn't actually static. For reference, if we
    # build go-measurement-kit for Windows using the library that we have
    # compiled here, everything works and is actually static.

    system "./autogen.sh", "-n"
    system "cross-mingw", "x86_64", "./configure", "--prefix=#{prefix}",
                          "--disable-shared",
                          "--disable-dependency-tracking",
                          "--with-libevent=/usr/local/opt/mingw-w64-libevent",
                          "--with-openssl=/usr/local/opt/mingw-w64-libressl",
                          "--with-libcurl=no",
                          "--with-libmaxminddb=/usr/local/opt/mingw-w64-libmaxminddb"
    system "make", "V=0"
    system "make", "V=0", "install"
  end
end
