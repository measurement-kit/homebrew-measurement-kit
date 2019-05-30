class IosLibevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.10-stable.tar.gz"
  sha256 "52c9db0bc5b148f146192aa517db0762b2a5b3060ccc63b2c470982ec72b9a79"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "c8c2da0e160c49c6035fc2d75656d08f1b02858b0a6cca57bd271e27ea444b4e" => :mojave
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
