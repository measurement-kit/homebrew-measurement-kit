class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "0.10.4"
  url "https://github.com/measurement-kit/measurement-kit/archive/v0.10.4.tar.gz"
  sha256 "6ca0d9e7a9c1ff0ea8713bf59fde9f87365acdc4b784a5a4bb3f35a77bc4b775"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "cbf8608a90d18e2ee35dabe5775428ac38d013b7c14e6c8c095ab373d728b7ef" => :mojave
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
