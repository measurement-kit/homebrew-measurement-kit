class MingwW64Libressl < Formula
  desc "Version of the SSL/TLS protocol forked from OpenSSL"
  homepage "https://www.libressl.org/"
  # Please ensure when updating version the release is from stable branch.
  url "https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.1.1.tar.gz"
  mirror "https://mirrorservice.org/pub/OpenBSD/LibreSSL/libressl-3.1.1.tar.gz"
  sha256 "bdc6ce5ebb3a2eafc4c475f7eeaa5f0a8e60d9bead01efb76e2e254242b6db00"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "361c8cf19bbcf56087ad473fe4070a1189574245d1b657aa09588ee84a4329d8" => :catalina
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cross" => :build
  depends_on "mingw-w64" => :build

  keg_only "this is a Windows build that we should not install system wide"

  patch :DATA

  def install
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    system "autoreconf", "-vif"
    system "cross-mingw", "x86_64", "./configure",
                          "--disable-dependency-tracking",
                          "--disable-shared",
                          "--prefix=#{prefix}",
                          "--with-openssldir=#{etc}/libressl",
                          "--sysconfdir=#{etc}/libressl"
    system "make", "install"
  end
end

__END__
From f9e21798fb795188a21ac7dd5ed0d9b6adf29f8c Mon Sep 17 00:00:00 2001
From: AntonioLangiu <antonio.langiu@studenti.polito.it>
Date: Fri, 22 Apr 2016 16:29:36 +0200
Subject: [PATCH 505/505] build just needed subdir

---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 48da18b..9164e20 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,4 +1,4 @@
-SUBDIRS = crypto ssl tls include apps man
+SUBDIRS = crypto ssl include
 if ENABLE_TESTS
 SUBDIRS += tests
 endif
