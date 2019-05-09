class MingwW64Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.64.1.tar.bz2"
  sha256 "4cc7c738b35250d0680f29e93e0820c4cb40035f43514ea3ec8d60322d41a45d"

  keg_only :provided_by_macos  # Not very accurate

  depends_on "pkg-config" => :build
  depends_on "mingw-w64" => :build
  depends_on "mingw-w64-libressl"

  def install

    ENV['AR'] = 'x86_64-w64-mingw32-ar'
    ENV['AS'] = 'x86_64-w64-mingw32-as'
    ENV['CC'] = 'x86_64-w64-mingw32-gcc'
    ENV['CFLAGS'] = '-Wall -O2'
    ENV['CPP'] = 'x86_64-w64-mingw32-cpp'
    ENV['CXX'] = 'x86_64-w64-mingw32-g++'
    ENV['CXXFLAGS'] = '-Wall -O2'
    ENV['LD'] = 'x86_64-w64-mingw32-ld'
    ENV['NM'] = 'x86_64-w64-mingw32-nm'
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
    ENV['RANLIB'] = 'x86_64-w64-mingw32-ranlib'
    ENV['STRIP'] = 'x86_64-w64-mingw32-strip'

    args = %W[
      --disable-debug
      --host=x86_64-w64-mingw32
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

    system "./configure", *args
    system "make", "install"
  end
end
