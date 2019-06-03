class Cross < Formula
  desc "Cross build scripts for MK"
  homepage "https://measurement-kit.github.io/"
  version "0.4.1"
  url "https://github.com/measurement-kit/cross/archive/v0.4.1.tar.gz"
  sha256 "1b026beb7ec896fac5de6b8da5072cde507aca944cfd6a64323cdcc9ad3f6014"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf -vif"
    system "./configure", "--prefix=#{prefix}"
    system "make", "V=0", "install"
  end
end
