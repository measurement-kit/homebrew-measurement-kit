class IosLibevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "https://github.com/libevent/libevent/archive/release-2.1.11-stable.tar.gz"
  sha256 "229393ab2bf0dc94694f21836846b424f3532585bac3468738b7bf752c03901e"
  revision 2

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "7257b420305fda80b70c02f486c63a3387c3cf350f02a70ed365ab05548f13ff" => :catalina
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "cross" => :build
  depends_on "ios-libressl"

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
