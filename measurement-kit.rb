class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.10.0"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.0.tar.gz"
  sha256 "c31ff8a457dfdbb2d42ef60f82646e508f6649107f15eec31fc22bc140ceb8e6"

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
