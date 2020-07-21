class MingwW64MeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.12"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.12.tar.gz"
  sha256 "508d9db72579efbe4747dd791771f47299bc5867c72d67a86e371d66d20fd19e"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "97eaee1daefcdb3fb289569a1cd1e2f4da25475108caaeda7cbaf2187f827e92" => :catalina
  end

  depends_on "mingw-w64-libevent"
  depends_on "mingw-w64-libmaxminddb"

  depends_on "cross" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "git" => :build
  depends_on "libtool" => :build

  keg_only "this is a Windows build that we should not install system wide"

  patch :DATA

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
__END__
We need to link with iphlpapi for if_nametoindex in libevent 2.1.12.

See https://github.com/measurement-kit/measurement-kit/pull/1930.

diff --git a/configure.ac b/configure.ac
index 29ff69bb..13c1bb8a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -13,8 +13,8 @@ AC_PROG_INSTALL
 
 case "$host" in
   *-w64-mingw32)
-    # Must link with ws2_32
-    LIBS="$LIBS -lws2_32"
+    # Must link with ws2_32 and iphlpapi for if_nametoindex (since libevent 2.1.12)
+    LIBS="$LIBS -lws2_32 -liphlpapi"
     # Required to expose inet_pton()
     CPPFLAGS="$CPPFLAGS -D_WIN32_WINNT=0x0600 -D_POSIX_C_SOURCE"
   ;;
