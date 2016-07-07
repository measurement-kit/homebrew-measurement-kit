class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  url "https://github.com/measurement-kit/measurement-kit.git",
    :tag => "v0.2.0"

  depends_on "libevent"
  depends_on "geoip"
  depends_on "git"
  depends_on "autoconf"
  depends_on "automake"
  depends_on "libtool"
  depends_on "wget"

  head do
    url "https://github.com/measurement-kit/measurement-kit.git",
      :branch => "master"
  end

  def install
    system "./autogen.sh"
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
