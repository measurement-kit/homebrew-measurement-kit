class IosLibmaxminddb < Formula
  desc "C library for the MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/libmaxminddb/releases/download/1.3.2/libmaxminddb-1.3.2.tar.gz"
  sha256 "e6f881aa6bd8cfa154a44d965450620df1f714c6dc9dd9971ad98f6e04f6c0f0"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "c8f9c66df0e0f4d2d38a9e2bc0ce37c969e23608fc44b707a709f9e357a2e60d" => :mojave
  end

  depends_on "cross" => :build

  keg_only "iOS build that we should not install system wide"

  def install
    for arch in [ "i386", "x86_64", "armv7s", "arm64" ] do
      system "cross-configure-ios", "#{arch}", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-shared",
                            "--disable-tests",
                            "--prefix=#{prefix}/#{arch}"
      system "make", "install"
      system "make", "distclean"
    end
  end
end
