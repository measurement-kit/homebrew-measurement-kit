class MeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.6"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.6.tar.gz"
  sha256 "5ec94e522c3bc43cbf749659c18d4b13bcfbb2874db4d6b4e21b160d76dd5bd0"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "6f66f6cf39ec230685723f4eb1efc309ce68703643e636acffc61de2676c53cd" => :mojave
  end

  depends_on "libevent"
  depends_on "libmaxminddb"
  #depends_on "curl" # Wrong! we want to depend on macOS's curl
  depends_on "openssl@1.1"

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
