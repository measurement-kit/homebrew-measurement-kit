class Libndt < Formula
  desc "NDT C++11 client library"
  homepage "https://measurement-kit.github.io/"
  version "v0.23.0"
  url "https://github.com/measurement-kit/libndt/archive/v0.23.0.tar.gz"
  sha256 "66ece68f0c79b3cd96b4e27ef9a2ae8815c475bf3b2562a8e295566dc2464df1"

  depends_on "cmake" => :build

  def install
    system "cmake", "-DCMAKE_BUILD_TYPE=Release", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "."
    system "cmake", "--build", "."
    system "./tests"
    system "make", "install"
  end
end
