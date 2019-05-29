class MingwW64Libressl < Formula
  desc "Version of the SSL/TLS protocol forked from OpenSSL"
  homepage "https://www.libressl.org/"
  # Please ensure when updating version the release is from stable branch.
  url "https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.9.2.tar.gz"
  mirror "https://mirrorservice.org/pub/OpenBSD/LibreSSL/libressl-2.9.2.tar.gz"
  sha256 "c4c78167fae325b47aebd8beb54b6041d6f6a56b3743f4bd5d79b15642f9d5d4"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "f6f8f3673cebdb526d9bf3779830384c68ae57c1cee507c08ec066eae7a1e2b9" => :mojave
  end

  depends_on "mingw-w64" => :build

  keg_only "Windows build that we should not install system wide"

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
