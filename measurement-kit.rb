class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.10.4"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.4.tar.gz"
  sha256 "6ca0d9e7a9c1ff0ea8713bf59fde9f87365acdc4b784a5a4bb3f35a77bc4b775"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "afc26befc6aa2ebae8e8cf3dfe64f186e738e0336e1b67a2765757f6840435be" => :mojave
  end

  depends_on "libevent"
  depends_on "libmaxminddb"
  #depends_on "curl" # Wrong! we want to depend on macOS's curl

  depends_on "git" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  head do
    url "https://github.com/measurement-kit/measurement-kit.git",
      :branch => "master"
  end

  def install
    system "./autogen.sh", "-n"
    system "./configure", "--prefix=#{prefix}", "--enable-shared"
    system "make", "V=0"
    system "make", "V=0", "install"
  end
end
