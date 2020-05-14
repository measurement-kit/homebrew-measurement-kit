class MingwW64Libmaxminddb < Formula
  desc "C library for the MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/libmaxminddb/releases/download/1.4.2/libmaxminddb-1.4.2.tar.gz"
  sha256 "dd582aa971be23dee960ec33c67fb5fd38affba508e6f00ea75959dbd5aad156"
  revision 3

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "2943f8c0f37a53c25e92891b07c76edb758241d7ef4646fcb6417e11631529b4" => :catalina
  end

  depends_on "cross" => :build
  depends_on "mingw-w64" => :build

  keg_only "this is a Windows build that we should not install system wide"

  def install
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    system "cross-mingw", "x86_64", "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-shared",
                          "--disable-tests",
                          "--disable-binaries",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
