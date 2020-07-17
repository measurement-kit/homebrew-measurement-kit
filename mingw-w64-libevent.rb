class MingwW64Libevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.12-stable.tar.gz"
  sha256 "7180a979aaa7000e1264da484f712d403fcf7679b1e9212c4e3d09f5c93efc24"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "de487ac1f00d72a2d4748b51afed4a9e0ea31cdd7ab3e8477aa507d8a76292e6" => :catalina
  end

  depends_on "mingw-w64-libressl"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cross" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  keg_only "this is a Windows build that we should not install system wide"

  def install
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    ENV['CPPFLAGS'] = '-I/usr/local/opt/mingw-w64-libressl/include -Wno-cpp'
    ENV['LDFLAGS'] = '-L/usr/local/opt/mingw-w64-libressl/lib'
    system "./autogen.sh"
    system "cross-mingw", "x86_64", "./configure", "--disable-dependency-tracking",
                          "--disable-debug-mode",
                          "--disable-shared",
                          "--disable-samples",
                          "--disable-libevent-regress",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
