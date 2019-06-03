class Cross < Formula
  desc "Cross build scripts for MK"
  homepage "https://measurement-kit.github.io/"
  version "0.4.0"
  url "https://github.com/measurement-kit/cross/archive/v0.4.0.tar.gz"
  sha256 "7a4cb524815f9759a363f19f28cd8e496e9c6c5dedc67696e52e6ecefc37af63"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf -vif"
    system "./configure", "--prefix=#{prefix}"
    system "make", "V=0", "install"
  end
end
