class MingwW64Libevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.10-stable.tar.gz"
  sha256 "52c9db0bc5b148f146192aa517db0762b2a5b3060ccc63b2c470982ec72b9a79"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "7b0f3849697029fdf43fcd053548c0d14c4074af0fb08c7be9c9ccd73918862b" => :mojave
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "mingw-w64-libressl"

  keg_only "Windows build that we should not install system wide"

  def install

    ENV['AR'] = 'x86_64-w64-mingw32-ar'
    ENV['AS'] = 'x86_64-w64-mingw32-as'
    ENV['CC'] = 'x86_64-w64-mingw32-gcc'
    ENV['CPPFLAGS'] = '-I/usr/local/opt/mingw-w64-libressl/include -Wno-cpp'
    ENV['CFLAGS'] = '-Wall -O2'
    ENV['CPP'] = 'x86_64-w64-mingw32-cpp'
    ENV['CXX'] = 'x86_64-w64-mingw32-g++'
    ENV['CXXFLAGS'] = '-Wall -O2'
    ENV['LD'] = 'x86_64-w64-mingw32-ld'
    ENV['LDFLAGS'] = '-L/usr/local/opt/mingw-w64-libressl/lib'
    ENV['NM'] = 'x86_64-w64-mingw32-nm'
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    ENV['RANLIB'] = 'x86_64-w64-mingw32-ranlib'
    ENV['STRIP'] = 'x86_64-w64-mingw32-strip'

    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--host=x86_64-w64-mingw32",
                          "--disable-debug-mode",
                          "--disable-shared",
                          "--disable-samples",
                          "--disable-libevent-regress",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
