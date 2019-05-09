class MingwW64Libressl < Formula
  desc "Version of the SSL/TLS protocol forked from OpenSSL"
  homepage "https://www.libressl.org/"
  # Please ensure when updating version the release is from stable branch.
  url "https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.9.1.tar.gz"
  mirror "https://mirrorservice.org/pub/OpenBSD/LibreSSL/libressl-2.9.1.tar.gz"
  sha256 "39e4dd856694dc10d564201e4549c46d2431601a2b10f3422507e24ccc8f62f8"

  depends_on "mingw-w64" => :build

  keg_only :provided_by_macos  # Not very accurate

  def install

    ENV['AR'] = 'x86_64-w64-mingw32-ar'
    ENV['AS'] = 'x86_64-w64-mingw32-as'
    ENV['CC'] = 'x86_64-w64-mingw32-gcc'
    ENV['CFLAGS'] = '-Wall -O2'
    ENV['CPP'] = 'x86_64-w64-mingw32-cpp'
    ENV['CXX'] = 'x86_64-w64-mingw32-g++'
    ENV['CXXFLAGS'] = '-Wall -O2'
    ENV['LD'] = 'x86_64-w64-mingw32-ld'
    ENV['NM'] = 'x86_64-w64-mingw32-nm'
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    ENV['RANLIB'] = 'x86_64-w64-mingw32-ranlib'
    ENV['STRIP'] = 'x86_64-w64-mingw32-strip'

    system "./configure", "--host=x86_64-w64-mingw32",
                          "--disable-dependency-tracking",
                          "--disable-shared",
                          "--prefix=#{prefix}",
                          "--with-openssldir=#{etc}/libressl",
                          "--sysconfdir=#{etc}/libressl"
    system "make", "install"
  end
end
