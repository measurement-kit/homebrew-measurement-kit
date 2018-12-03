class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.9.0"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.9.0.tar.gz"
  sha256 "6ad1901491f908d004d3b900dea73c5aed3356f8a19c46d80f78b2dbd89fc55c"

  depends_on "libevent"
  depends_on "geoip"
  depends_on "git" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  head do
    url "https://github.com/measurement-kit/measurement-kit.git",
      :branch => "master"
  end

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--enable-shared"
    system "make", "V=0"
    system "make", "V=0", "install"
  end
end
