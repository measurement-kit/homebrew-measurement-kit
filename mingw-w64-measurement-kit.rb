class MingwW64MeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.8"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.8.tar.gz"
  sha256 "773c0f03fa21b56b34a24f97b4fedf96e66b0f49ef549d5c674e63ed43e1c278"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "db6456dc26606f70ee2a565a8416b5028dc84b701a4cf3d2d36dbd39a6f65be5" => :mojave
  end

  depends_on "mingw-w64-libevent"
  depends_on "mingw-w64-libmaxminddb"
  depends_on "mingw-w64-curl"

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
                          "--with-libcurl=/usr/local/opt/mingw-w64-curl",
                          "--with-libmaxminddb=/usr/local/opt/mingw-w64-libmaxminddb"
    system "make", "V=0"
    system "make", "V=0", "install"
  end
end
