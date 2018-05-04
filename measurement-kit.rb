class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.8.3"
  url "https://github.com/measurement-kit/measurement-kit/releases/download/v0.8.3/measurement-kit-0.8.3.tar.gz"
  sha256 "777e6fbe985ace106b8c2514b7d51277d5e7ad4a3970b45a2758b845af3dd9f6"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "dc3f0e0d55efdf8f75ab620a1324ad6cb590a71e90c796e9e86b2981c3d322bc" => :high_sierra
  end

  depends_on "libevent"
  depends_on "geoip"

  head do
    url "https://github.com/measurement-kit/measurement-kit.git",
      :branch => "master"
    depends_on "git" => :build
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "wget" => :build
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}", "--disable-examples"
    system "make", "V=0"
    system "make", "V=0", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <measurement_kit/common.h>
      int main() {
        mk::loop_with_initial_event([]() {
          mk::call_later(1.0, []() {
            mk::break_loop();
          });
        });
      }
    EOS
    system ENV.cxx, "test.cpp", "-lmeasurement_kit", "-o", "test"
    system "./test"
  end
end
