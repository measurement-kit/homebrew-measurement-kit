class MingwW64Libevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.8-stable.tar.gz"
  sha256 "316ddb401745ac5d222d7c529ef1eada12f58f6376a66c1118eee803cb70f83d"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "mingw-w64-libressl"

  keg_only :provided_by_macos  # Not very accurate

  patch :DATA

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

__END__
--- a/configure.ac
+++ b/configure.ac
@@ -342,6 +342,7 @@ AC_CHECK_FUNCS([ \
   accept4 \
   arc4random \
   arc4random_buf \
+  arc4random_addrandom \
   eventfd \
   epoll_create1 \
   fcntl \
--- a/evutil_rand.c
+++ b/evutil_rand.c
@@ -184,6 +184,24 @@ ev_arc4random_buf(void *buf, size_t n)
 	arc4random_buf(buf, n);
 }
 
+/*
+ * The arc4random included in libevent implements arc4random_addrandom().
+ *
+ * OpenBSD libc/crypt/arc4random.c migrated to ChaCha20 since 1.25 and
+ * have removed arc4random_addrandom() since 1.26. Since then, other libcs
+ * followed suit (e.g. Android's own libc). But libevent's arc4random.c
+ * copy still implement arc4random_addrandom().
+ *
+ * See also:
+ *
+ * - https://github.com/measurement-kit/libevent/commit/8b275d967d7ffd95d5cc12069aef35669126c6d9
+ * - https://bugzilla.mozilla.org/show_bug.cgi?id=931354
+ * - https://bug931354.bmoattachments.org/attachment.cgi?id=829728
+ */
+#ifndef EVENT__HAVE_ARC4RANDOM_ADDRANDOM
+#define EVENT__HAVE_ARC4RANDOM_ADDRANDOM 1
+#endif
+
 #endif /* } !EVENT__HAVE_ARC4RANDOM */
 
 void
@@ -195,8 +213,10 @@ evutil_secure_rng_get_bytes(void *buf, size_t n)
 void
 evutil_secure_rng_add_bytes(const char *buf, size_t n)
 {
+#if defined EVENT__HAVE_ARC4RANDOM_ADDRANDOM
 	arc4random_addrandom((unsigned char*)buf,
 	    n>(size_t)INT_MAX ? INT_MAX : (int)n);
+#endif
 }
 
 void
--- a/m4/libevent_openssl.m4
+++ b/m4/libevent_openssl.m4
@@ -20,6 +20,7 @@ case "$enable_openssl" in
 	OPENSSL_INCS=`$PKG_CONFIG --cflags openssl 2>/dev/null`
 	;;
     esac
+    have_openssl=yes  # Fix cross build issue found by @hellais and @sarath
     case "$have_openssl" in
      yes) ;;
      *)
--- a/openssl-compat.h
+++ b/openssl-compat.h
@@ -1,8 +1,9 @@
 #ifndef OPENSSL_COMPAT_H
 #define OPENSSL_COMPAT_H
 
-#if OPENSSL_VERSION_NUMBER < 0x10100000L
+#if OPENSSL_VERSION_NUMBER < 0x10100000L || defined LIBRESSL_VERSION_NUMBER
 
+#if defined LIBRESSL_VERSION_NUMBER && LIBRESSL_VERSION_NUMBER < 0x2070000fL
 static inline BIO_METHOD *BIO_meth_new(int type, const char *name)
 {
 	BIO_METHOD *biom = calloc(1, sizeof(BIO_METHOD));
@@ -20,6 +21,7 @@ static inline BIO_METHOD *BIO_meth_new(int type, const char *name)
 #define BIO_meth_set_ctrl(b, f) (b)->ctrl = (f)
 #define BIO_meth_set_create(b, f) (b)->create = (f)
 #define BIO_meth_set_destroy(b, f) (b)->destroy = (f)
+#endif  /* LIBRESSL_VERSION_NUMBER && LIBRESSL_VERSION_NUMBER < 0x2070000fL */
 
 #define BIO_set_init(b, val) (b)->init = (val)
 #define BIO_set_data(b, val) (b)->ptr = (val)
@@ -28,8 +30,10 @@ static inline BIO_METHOD *BIO_meth_new(int type, const char *name)
 #define BIO_get_data(b) (b)->ptr
 #define BIO_get_shutdown(b) (b)->shutdown
 
+#if defined LIBRESSL_VERSION_NUMBER && LIBRESSL_VERSION_NUMBER < 0x2070000fL
 #define TLS_method SSLv23_method
+#endif  /* LIBRESSL_VERSION_NUMBER && LIBRESSL_VERSION_NUMBER < 0x2070000fL */
 
-#endif /* OPENSSL_VERSION_NUMBER < 0x10100000L */
+#endif /* OPENSSL_VERSION_NUMBER < 0x10100000L || defined LIBRESSL_VERSION_NUMBER */
 
 #endif /* OPENSSL_COMPAT_H */

