class IosCurl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.67.0.tar.bz2"
  sha256 "dd5f6956821a548bf4b44f067a530ce9445cc8094fd3e7e3fc7854815858586c"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "3b9fff81298d756074ee78e10c41fd2a7065663523a583da8914e167b4ecaf35" => :mojave
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
