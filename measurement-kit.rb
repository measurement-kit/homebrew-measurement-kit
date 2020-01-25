class MeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.8"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.8.tar.gz"
  sha256 "773c0f03fa21b56b34a24f97b4fedf96e66b0f49ef549d5c674e63ed43e1c278"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "bf1868173b9717f8f284bb791288299931d516e44838d5eeb7b31a5dc7b192b2" => :mojave
    sha256 "d90321774a99417208fc91afcc4824b41cc939923b77302934490e7d83d26efb" => :catalina
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
