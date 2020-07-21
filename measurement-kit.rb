class MeasurementKit < Formula
  desc "Network measurement engine"
  homepage "https://measurement-kit.github.io/"
  version "0.10.12"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.12.tar.gz"
  sha256 "508d9db72579efbe4747dd791771f47299bc5867c72d67a86e371d66d20fd19e"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "dda0fc2d5d7ff1d0e444e3a2ffad2216270c805046d0fe64338bf2e31a8ff6b4" => :catalina
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
