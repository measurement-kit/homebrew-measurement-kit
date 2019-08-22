class MeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.5"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.5.tar.gz"
  sha256 "8b83f04f4d3c653f93bcee5a6cc5e32e6595a3feb99526017d78099fd90d4a75"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "09cdbfb3b9e4328aa034df0111ffd65b1772b31e5919edd64a14dfa11e6f89f3" => :mojave
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
