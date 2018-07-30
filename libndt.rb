class Libndt < Formula
  desc "NDT C++11 client library"
  homepage "https://measurement-kit.github.io/"
  version "v0.25.1"
  url "https://github.com/measurement-kit/libndt/archive/v0.25.1.tar.gz"
  sha256 "42fff0e108ea816fb76218e923c8b44a02eb478b115fd7e460d7f76880b783e2"

  depends_on "cmake" => :build

  def install
    system "cmake", "-DCMAKE_BUILD_TYPE=Release", "-DBUILD_SHARED_LIBS=ON", \
        "-DCMAKE_INSTALL_PREFIX=#{prefix}", "."
    system "cmake", "--build", "."
    system "./tests"
    system "make", "install"
  end
end
