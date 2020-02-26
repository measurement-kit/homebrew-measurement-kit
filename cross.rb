class Cross < Formula
  desc "Cross build scripts for MK"
  homepage "https://measurement-kit.github.io/"
  version "0.4.5"
  url "https://github.com/measurement-kit/cross/archive/v0.4.5.tar.gz"
  sha256 "0698a5b9526b16a8ba007fc5a0d28e5730d958fc5887b36bac4f417c4f26cb23"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf -vif"
    system "./configure", "--prefix=#{prefix}"
    system "make", "V=0", "install"
  end
end
