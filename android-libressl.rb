class AndroidLibressl < Formula
  desc "Version of the SSL/TLS protocol forked from OpenSSL"
  homepage "https://www.libressl.org/"
  # Please ensure when updating version the release is from stable branch.
  url "https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.0.2.tar.gz"
  mirror "https://mirrorservice.org/pub/OpenBSD/LibreSSL/libressl-3.0.2.tar.gz"
  sha256 "df7b172bf79b957dd27ef36dcaa1fb162562c0e8999e194aa8c1a3df2f15398e"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "c2cc9ad3cfe11e39622e669b801fb1e4e6adec2bd24336d8855da768d0cd2c1b" => :mojave
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cross" => :build

  keg_only "this is an Android build that we should not install system wide"

  patch :DATA

  def install
    ENV['ANDROID_NDK_ROOT'] = '/usr/local/share/android-sdk/ndk-bundle'
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    system "autoreconf", "-vif"
    [ "x86", "x86_64", "armeabi-v7a", "arm64-v8a" ].each do |arch|
      mkdir "build-#{arch}" do
        system "cross-android", "#{arch}", "../configure", "--disable-debug",
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

