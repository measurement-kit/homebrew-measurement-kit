class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  url "https://github.com/measurement-kit/measurement-kit/releases/download/v0.3.3/measurement-kit-0.3.3.tar.gz"
  sha256 "80172988d15ac775984a1f3705bcc9c5f9e250f4f2f8671188260330bfb80eb0"

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
