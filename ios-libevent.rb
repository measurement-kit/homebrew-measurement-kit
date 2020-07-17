class IosLibevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.12-stable.tar.gz"
  sha256 "7180a979aaa7000e1264da484f712d403fcf7679b1e9212c4e3d09f5c93efc24"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "c196301332bab839423a5d29e3e61f598d84091bcb2b67ad88b84fba8e2417c0" => :catalina
  end

  depends_on "ios-libressl"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cross" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  keg_only "this is an iOS build that we should not install system wide"

  def install
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
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
