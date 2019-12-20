class MingwW64Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.67.0.tar.bz2"
  sha256 "dd5f6956821a548bf4b44f067a530ce9445cc8094fd3e7e3fc7854815858586c"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "d2926a655472ac085723da8c60d1442143d6cdae0ef5a4896b3f0fc3f278f04f" => :mojave
  end

  keg_only "this is a Windows build that we should not install system wide"

  depends_on "cross" => :build
  depends_on "mingw-w64" => :build
  depends_on "mingw-w64-libressl"
  depends_on "pkg-config" => :build

  def install
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-shared
      --disable-tests
      --prefix=#{prefix}
      --without-ca-bundle
      --without-ca-path
      --disable-ftp
      --disable-file
      --disable-ldap
      --disable-ldaps
      --disable-rtsp
      --disable-dict
      --disable-telnet
      --disable-tftp
      --disable-pop3
      --disable-imap
      --disable-smb
      --disable-smtp
      --disable-gopher
      --disable-manual
      --enable-ipv6
      --disable-sspi
      --disable-ntlm-wb
      --disable-tls-srp
      --with-pic=yes
      --without-libidn2
      --without-zlib
      --disable-rt
      --disable-threaded-resolver
      --with-ssl=/usr/local/opt/mingw-w64-libressl
    ]
    system "cross-mingw", "x86_64", "./configure", *args
    system "make", "install"
  end
end
