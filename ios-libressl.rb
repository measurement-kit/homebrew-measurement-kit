class IosLibressl < Formula
  desc "Version of the SSL/TLS protocol forked from OpenSSL"
  homepage "https://www.libressl.org/"
  # Please ensure when updating version the release is from stable branch.
  url "https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.9.2.tar.gz"
  mirror "https://mirrorservice.org/pub/OpenBSD/LibreSSL/libressl-2.9.2.tar.gz"
  sha256 "c4c78167fae325b47aebd8beb54b6041d6f6a56b3743f4bd5d79b15642f9d5d4"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "5d6c27fca996a0df8a5e6454d1fad6d238b60e6eb47ca91c8f6f6002835b7ff7" => :mojave
  end

  depends_on "cross" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  keg_only "iOS build that we should not install system wide"

  patch :DATA

  def install
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    system "autoreconf", "-vif"
    [ "i386", "x86_64", "armv7s", "arm64" ].each do |arch|
      mkdir "build-#{arch}" do
        system "cross-ios", "#{arch}", "../configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-shared",
                            "--prefix=#{prefix}/#{arch}",
                            "--with-openssldir=#{etc}/libressl",
                            "--sysconfdir=#{etc}/libressl"
        system "make", "install"
      end
    end
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
-SUBDIRS = crypto ssl tls include apps tests man
+SUBDIRS = crypto ssl include
 ACLOCAL_AMFLAGS = -I m4
 
 pkgconfigdir = $(libdir)/pkgconfig
-- 
2.8.1

