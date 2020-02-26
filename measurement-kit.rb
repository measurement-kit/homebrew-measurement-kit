class MeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.11"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.11.tar.gz"
  sha256 "f9dbf5f721516fd709c13ac5011737b3622076299e3c899a1f70861901ec1b40"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "218923f4387325ec77adb52095680df188713b7fb8d16736ab3062b85e10015d" => :catalina
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
