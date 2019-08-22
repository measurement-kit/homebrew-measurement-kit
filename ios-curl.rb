class IosCurl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.65.3.tar.bz2"
  sha256 "0a855e83be482d7bc9ea00e05bdb1551a44966076762f9650959179c89fce509"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "eb742416884117083a5b6e8ca0a1433067a0f479f28f6eaca7d54509aa9857f3" => :mojave
  end

  keg_only "iOS build that we should not install system wide"

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
