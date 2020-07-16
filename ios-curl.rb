class IosCurl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.71.1.tar.xz"
  sha256 "40f83eda27cdbeb25cd4da48cefb639af1b9395d6026d2da1825bf059239658c"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    cellar :any_skip_relocation
    sha256 "c57a5238598f25b9e68f3fae3340b181962c6896538d8f055198835a11a27708" => :catalina
  end

  keg_only "this is an iOS build that we should not install system wide"

  depends_on "cross" => :build
  depends_on "ios-libressl"
  depends_on "pkg-config" => :build

  def install
    ENV['PATH'] = '/usr/local/bin:/usr/bin:/bin'
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
