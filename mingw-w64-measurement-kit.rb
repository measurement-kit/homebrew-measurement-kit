class MingwW64MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.10.3"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.3.tar.gz"
  sha256 "04bc1832fbaa54a9fde4923e8f44a2f99610a862c228dd05977c36f54870d80f"

  depends_on "mingw-w64-libevent"
  depends_on "mingw-w64-libmaxminddb"
  depends_on "mingw-w64-curl"

  depends_on "git" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  keg_only :provided_by_macos  # Not very accurate

  def install

    ENV['AR'] = 'x86_64-w64-mingw32-ar'
    ENV['AS'] = 'x86_64-w64-mingw32-as'
    ENV['CC'] = 'x86_64-w64-mingw32-gcc'
    ENV['CPPFLAGS'] = '-Wall -O2 -Wno-cpp'
    ENV['CFLAGS'] = '-Wall -O2'
    ENV['CPP'] = 'x86_64-w64-mingw32-cpp'
    ENV['CXX'] = 'x86_64-w64-mingw32-g++'
    ENV['CXXFLAGS'] = '-Wall -O2'
    ENV['LDFLAGS'] = '-static'
    ENV['LD'] = 'x86_64-w64-mingw32-ld'
    ENV['NM'] = 'x86_64-w64-mingw32-nm'
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    ENV['RANLIB'] = 'x86_64-w64-mingw32-ranlib'
    ENV['STRIP'] = 'x86_64-w64-mingw32-strip'

    # TODO(bassosimone): figure out why the measurement_kit binary built
    # using this procedure isn't actually static. For reference, if we
    # build go-measurement-kit for Windows using the library that we have
    # compiled here, everything works and is actually static.

    system "./autogen.sh", "-n"
    system "./configure", "--prefix=#{prefix}",
                          "--host=x86_64-w64-mingw32",
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
