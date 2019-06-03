class Cross < Formula
  desc "Cross build scripts for MK"
  homepage "https://measurement-kit.github.io/"
  version "0.4.2"
  url "https://github.com/measurement-kit/cross/archive/v0.4.2.tar.gz"
  sha256 "ef034fc84a9765d68c3ba1fa69dd5466c06e92b47bbaa595e18d52d00c544099"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf -vif"
    system "./configure", "--prefix=#{prefix}"
    system "make", "V=0", "install"
  end
end
