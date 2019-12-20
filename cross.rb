class Cross < Formula
  desc "Cross build scripts for MK"
  homepage "https://measurement-kit.github.io/"
  version "0.4.4"
  url "https://github.com/measurement-kit/cross/archive/v0.4.4.tar.gz"
  sha256 "d775612ece32584a35175584d3c2111cbba639c44d64822520a44d03f537f5a5"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf -vif"
    system "./configure", "--prefix=#{prefix}"
    system "make", "V=0", "install"
  end
end
