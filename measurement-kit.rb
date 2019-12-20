class MeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.7"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.7.tar.gz"
  sha256 "abe8f2f24ed64c0fed9b439cb7f335456f11ac204a8d679c31595cdec87c6b7b"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "3f3591581fccabaa40e935de3d1a27da35654e89ef23b53cf424627f10d4f92f" => :mojave
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
