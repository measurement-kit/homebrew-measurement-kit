class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.8.0-beta.1"
  url "https://github.com/measurement-kit/measurement-kit/releases/download/v0.8.0-beta.1/measurement-kit-0.8.0-beta.1.tar.gz"
  sha256 "2cc0b394a5055d71f07c1673ee75904dc310ac847885dade771ad396b26cb777"

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
