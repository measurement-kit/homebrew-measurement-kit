class MingwW64Libmaxminddb < Formula
  desc "C library for the MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/libmaxminddb/releases/download/1.3.2/libmaxminddb-1.3.2.tar.gz"
  sha256 "e6f881aa6bd8cfa154a44d965450620df1f714c6dc9dd9971ad98f6e04f6c0f0"

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
    ENV['RANLIB'] = 'x86_64-w64-mingw32-ranlib'
    ENV['STRIP'] = 'x86_64-w64-mingw32-strip'

    system "./configure", "--disable-debug",
                          "--host=x86_64-w64-mingw32",
                          "--disable-dependency-tracking",
                          "--disable-shared",
                          "--disable-tests",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
