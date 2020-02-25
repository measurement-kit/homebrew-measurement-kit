class MeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.10"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.10.tar.gz"
  sha256 "47f3a77c5fb0674d1b3378bb6cebd1d23e8d8af955ae720243f3db25bd7e27ff"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "2c14776783613803ee4e84f9e3e85d9632bf4c113f7e5eb953639b8d3ac269ff" => :catalina
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
