class IosLibmaxminddb < Formula
  desc "C library for the MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/libmaxminddb/releases/download/1.3.2/libmaxminddb-1.3.2.tar.gz"
  sha256 "e6f881aa6bd8cfa154a44d965450620df1f714c6dc9dd9971ad98f6e04f6c0f0"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "08b292b748c4bb70eb4a3b845e2a9fa984733f0f30c0b95bee78d6ca1d1a8742" => :mojave
  end

  depends_on "cross" => :build

  keg_only "iOS build that we should not install system wide"

  def install
    [ "i386", "x86_64", "armv7s", "arm64" ].each do |arch|
      mkdir "build-#{arch}" do
        system "cross-ios", "#{arch}", "../configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-shared",
                            "--disable-tests",
                            "--prefix=#{prefix}/#{arch}"
        system "make", "install"
      end
    end
  end
end
