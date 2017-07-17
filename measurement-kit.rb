class MeasurementKit < Formula
  desc "Portable C++11 network measurement library"
  homepage "https://measurement-kit.github.io/"
  version "v0.7.0-beta"
  url "https://github.com/measurement-kit/measurement-kit/releases/download/v0.7.0-beta/measurement-kit-0.7.0-beta.tar.gz"
  sha256 "7b3e517cffad1d536b58567e7935d5dae4710d9e4c0f061fdd5c15bcdd868a9e"

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
