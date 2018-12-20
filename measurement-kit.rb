class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.9.1"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.9.1.tar.gz"
  sha256 "5a4f0ae8c9ed83f186231e4b04f25f026b8a46f4171045ef972c3d9bdc912081"

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
