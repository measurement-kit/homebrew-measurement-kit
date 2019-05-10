class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.10.3"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.3.tar.gz"
  sha256 "04bc1832fbaa54a9fde4923e8f44a2f99610a862c228dd05977c36f54870d80f"

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
