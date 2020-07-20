class IosMeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.12"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.12.tar.gz"
  sha256 "508d9db72579efbe4747dd791771f47299bc5867c72d67a86e371d66d20fd19e"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "f25c088aa35274c29d23378f782b36f8ca4789e4ff093b38e55ac1388dc04f58" => :catalina
  end

  depends_on "ios-libevent"
  depends_on "ios-libmaxminddb"
  depends_on "ios-curl"

  depends_on "git" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "cross" => :build

  keg_only "this is an iOS build that we should not install system wide"

  patch :DATA

  def install
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    system "./autogen.sh", "-n"
    [ "i386", "x86_64", "armv7s", "arm64" ].each do |arch|
      mkdir "build-#{arch}" do
        system "cross-ios", "#{arch}", "../configure", "--prefix=#{prefix}/#{arch}",
                            "--disable-shared",
                            "--disable-dependency-tracking",
                            "--with-libevent=/usr/local/opt/ios-libevent/#{arch}",
                            "--with-openssl=/usr/local/opt/ios-libressl/#{arch}",
                            "--with-libcurl=/usr/local/opt/ios-curl/#{arch}",
                            "--with-libmaxminddb=/usr/local/opt/ios-libmaxminddb/#{arch}"
        system "make", "V=0", "install"
      end
    end
  end
end
__END__
From 374049c98b61ce3625552c92d152a2c53055b05c Mon Sep 17 00:00:00 2001
From: Simone Basso <bassosimone@gmail.com>
Date: Wed, 26 Feb 2020 20:49:21 +0100
Subject: [PATCH] Makefile.am: don't build libtest.la by default

We will pick it up automatically when we build tests. So, no need to
explicitly list it as something to build. Fixes cross compiling for
iOS, where catch.hpp is clearly not prepared for that:

```
==> ./autogen.sh -n
==> cross-ios i386 ../configure --prefix=/usr/local/Cellar/ios-measurement-kit/0.10.11/i386 --disable-shared --disable-depen
==> make V=0 install
==> cross-ios x86_64 ../configure --prefix=/usr/local/Cellar/ios-measurement-kit/0.10.11/x86_64 --disable-shared --disable-d
==> make V=0 install
==> cross-ios armv7s ../configure --prefix=/usr/local/Cellar/ios-measurement-kit/0.10.11/armv7s --disable-shared --disable-d
==> make V=0 install
Last 15 lines from /Users/sbs/Library/Logs/Homebrew/ios-measurement-kit/07.make:
In file included from ../test/main.cpp:1:
../include/private/catch.hpp:8182:13: error: cannot determine Thumb instruction size, use inst.n/inst.w instead
            CATCH_BREAK_INTO_DEBUGGER();
            ^
../include/private/catch.hpp:7894:79: note: expanded from macro 'CATCH_BREAK_INTO_DEBUGGER'
    #define CATCH_BREAK_INTO_DEBUGGER() []{ if( Catch::isDebuggerActive() ) { CATCH_TRAP(); } }()
                                                                              ^
../include/private/catch.hpp:7872:39: note: expanded from macro 'CATCH_TRAP'
        #define CATCH_TRAP()  __asm__(".inst 0xe7f001f0")
                                      ^
<inline asm>:1:2: note: instantiated into assembly here
        .inst 0xe7f001f0
        ^
1 error generated.
make: *** [test/libtest_main_la-main.lo] Error 1
```
---
 Makefile.am | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 5a8e9417..58199c28 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,6 @@ measurement_kit_SOURCES       = # Empty
 bin_PROGRAMS = measurement_kit
 measurement_kit_LDADD = libmeasurement_kit.la
 
-noinst_LTLIBRARIES       = libtest_main.la
 libtest_main_la_CPPFLAGS = -DCATCH_CONFIG_MAIN
 libtest_main_la_SOURCES  = test/main.cpp
 
-- 
2.25.0

