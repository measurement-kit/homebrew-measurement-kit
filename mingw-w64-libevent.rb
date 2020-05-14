class MingwW64Libevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.11-stable.tar.gz"
  sha256 "229393ab2bf0dc94694f21836846b424f3532585bac3468738b7bf752c03901e"
  revision 4

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "e0ab41754244b0be8a075a77dca9e335d653891cc237db0042817a1a157afa2d" => :catalina
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cross" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "mingw-w64-libressl"

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
