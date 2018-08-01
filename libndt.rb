class Libndt < Formula
  desc "NDT C++11 client library"
  homepage "https://measurement-kit.github.io/"
  version "v0.26.0"
  url "https://github.com/measurement-kit/libndt/archive/v0.26.0.tar.gz"
  sha256 "84877c9f5b4e4bcd9f13a390709f894778ccc9cb4fc370e3696dd96873021b6a"

  depends_on "cmake" => :build

  def install
    system "cmake", "-DCMAKE_BUILD_TYPE=Release", \
        "-DCMAKE_INSTALL_PREFIX=#{prefix}", "."
    system "cmake", "--build", "."
    system "./tests-curl"
    system "./tests-libndt"
    system "make", "install"
  end
end
