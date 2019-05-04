class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.10.2"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.2.tar.gz"
  sha256 "580b036aa1d1b9c85b659ef1bb710ea64f9501aaa3394cc4e397a6dde10eebfa"

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
