class IosCurl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.68.0.tar.bz2"
  sha256 "207f54917dd6a2dc733065ccf18d61bb5bebeaceb5df49cd9445483e8623eeb9"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "3cfb441a4a7db4a89d8df2c261ab616e9921bdaa9ac2ff50bfa026182163b043" => :catalina
  end

  keg_only "this is an iOS build that we should not install system wide"

  depends_on "pkg-config" => :build
  depends_on "cross" => :build
  depends_on "ios-libressl"

  def install
    [ "i386", "x86_64", "armv7s", "arm64" ].each do |arch|
      mkdir "build-#{arch}" do
        args = %W[
          --disable-debug
          --disable-dependency-tracking
          --disable-shared
          --disable-tests
          --prefix=#{prefix}/#{arch}
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
          --with-ssl=/usr/local/opt/ios-libressl/#{arch}
        ]
        system "cross-ios", "#{arch}", "../configure", *args
        system "make", "install"
      end
    end
  end
end
