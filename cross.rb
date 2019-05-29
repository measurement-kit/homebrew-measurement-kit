class Cross < Formula
  desc "Cross build scripts for MK"
  homepage "https://measurement-kit.github.io/"
  version "0.3.0"
  url "https://github.com/measurement-kit/cross/archive/v0.3.0.tar.gz"
  sha256 "f6e9f18bf8d39f4cb6201e2b83a260de0953f56447be8500ed363bfcc71ecf1f"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf -vif"
    system "./configure", "--prefix=#{prefix}"
    system "make", "V=0", "install"
  end
end
