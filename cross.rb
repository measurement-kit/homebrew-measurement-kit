class Cross < Formula
  desc "Cross build scripts for MK"
  homepage "https://measurement-kit.github.io/"
  version "0.4.3"
  url "https://github.com/measurement-kit/cross/archive/v0.4.3.tar.gz"
  sha256 "19269f919c5b0d28985750bf5d4ee34b52f4db2d84ae13cbb33047c76f170957"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf -vif"
    system "./configure", "--prefix=#{prefix}"
    system "make", "V=0", "install"
  end
end
