class IosLibevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.11-stable.tar.gz"
  sha256 "229393ab2bf0dc94694f21836846b424f3532585bac3468738b7bf752c03901e"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "be69f25e253446a4b910565f863339a71c4290abe42dfe84614c952e4ddfa26e" => :mojave
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "cross" => :build
  depends_on "ios-libressl"

  keg_only "iOS build that we should not install system wide"

  def install
    system "./autogen.sh"
    [ "i386", "x86_64", "armv7s", "arm64" ].each do |arch|
      mkdir "build-#{arch}" do
        ENV["CPPFLAGS"] = "-I/usr/local/opt/ios-libressl/#{arch}/include"
        ENV["LDFLAGS"] = "-L/usr/local/opt/ios-libressl/#{arch}/lib"
        system "cross-ios", "#{arch}", "../configure",
                            "--disable-dependency-tracking",
                            "--disable-debug-mode",
                            "--disable-shared",
                            "--disable-samples",
                            "--disable-libevent-regress",
                            "--prefix=#{prefix}/#{arch}"
        system "make", "install"
      end
    end
  end
end
