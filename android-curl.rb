class AndroidCurl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.haxx.se/"
  url "https://curl.haxx.se/download/curl-7.71.1.tar.xz"
  sha256 "40f83eda27cdbeb25cd4da48cefb639af1b9395d6026d2da1825bf059239658c"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "471e5d46183fe25d6b514ac1d79354c130a71a2a80abccec870635b54ff23dd2" => :catalina
  end

  keg_only "this is an Android build that we should not install system wide"

  depends_on "cross" => :build
  depends_on "android-libressl"
  depends_on "pkg-config" => :build

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
