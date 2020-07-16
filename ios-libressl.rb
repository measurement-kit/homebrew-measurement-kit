class IosLibressl < Formula
  desc "Version of the SSL/TLS protocol forked from OpenSSL"
  homepage "https://www.libressl.org/"
  # Please ensure when updating version the release is from stable branch.
  url "https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.1.3.tar.gz"
  mirror "https://mirrorservice.org/pub/OpenBSD/LibreSSL/libressl-3.1.3.tar.gz"
  sha256 "c76b0316acf612ecb62f5cb014a20d972a663bd9e40abf952a86f3b998b69fa0"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "94e45caaa9df5d4a10e50105cdb2a9c8a58f5da18893d3b68743d4170bae6a73" => :catalina
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cross" => :build

  keg_only "this is an iOS build that we should not install system wide"

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
-SUBDIRS = crypto ssl tls include apps man
+SUBDIRS = crypto ssl include
 if ENABLE_TESTS
 SUBDIRS += tests
 endif
