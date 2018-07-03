class Libndt < Formula
  desc "NDT C++11 client library"
  homepage "https://measurement-kit.github.io/"
  version "v0.24.0"
  url "https://github.com/measurement-kit/libndt/archive/v0.24.0.tar.gz"
  sha256 "6b973b838764579614695994b8f90f588ca191e2dd42efc1165193eccbafa396"

  depends_on "cmake" => :build

  def install
    system "cmake", "-DCMAKE_BUILD_TYPE=Release", "-DBUILD_SHARED_LIBS=ON", \
        "-DCMAKE_INSTALL_PREFIX=#{prefix}", "."
    system "cmake", "--build", "."
    system "./tests"
    system "make", "install"
  end
end
