class Cross < Formula
  desc "Cross build scripts for MK"
  homepage "https://measurement-kit.github.io/"
  version "0.2.0"
  url "https://github.com/measurement-kit/cross/archive/v0.2.0.tar.gz"
  sha256 "4fe1d4819b75a26b86749c54d3be022a06bbfcb21b2c2a0ddfd0f0471489dcce"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf -vif"
    system "./configure", "--prefix=#{prefix}"
    system "make", "V=0", "install"
  end
end
