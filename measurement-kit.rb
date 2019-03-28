class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.10.1"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.1.tar.gz"
  sha256 "4caf856ebbb28633c7593a9b5b8ee79f0c0436d05ae7391cc59e8d72b260911a"

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
