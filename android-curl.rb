class AndroidCurl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.65.0.tar.bz2"
  sha256 "ea47c08f630e88e413c85793476e7e5665647330b6db35f5c19d72b3e339df5c"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "96ba0103d117c170f2f373e6fab2bd8954fbe2d6b34023726fbf8aba7c7ef6ba" => :mojave
  end

  keg_only "Android build that we should not install system wide"

  depends_on "pkg-config" => :build
  depends_on "cross" => :build
  depends_on "android-libressl"

  def install
    ENV['ANDROID_NDK_ROOT'] = '/usr/local/share/android-sdk/ndk-bundle'
    [ "x86", "x86_64", "armeabi-v7a", "arm64-v8a" ].each do |arch|
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
          --with-ssl=/usr/local/opt/android-libressl/#{arch}
        ]
        system "cross-android", "#{arch}", "../configure", *args
        system "make", "install"
      end
    end
  end
end
