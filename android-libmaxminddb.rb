class AndroidLibmaxminddb < Formula
  desc "C library for the MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/libmaxminddb/releases/download/1.4.2/libmaxminddb-1.4.2.tar.gz"
  sha256 "dd582aa971be23dee960ec33c67fb5fd38affba508e6f00ea75959dbd5aad156"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "3e0d465a72fc59a75236a62f35dc885262570f3522b028dd6ccb0fdcce2e7056" => :mojave
    sha256 "e5d0e5e9ec3bff2044559b9580bcd58abc28078a7f223668c2bf35096a48e6e5" => :catalina
  end

  depends_on "cross" => :build

  keg_only "this is an Android build that we should not install system wide"

  def install
    ENV['ANDROID_NDK_ROOT'] = '/usr/local/share/android-sdk/ndk-bundle'
    [ "x86", "x86_64", "armeabi-v7a", "arm64-v8a" ].each do |arch|
      mkdir "build-#{arch}" do
        system "cross-android", "#{arch}", "../configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-shared",
                            "--disable-tests",
                            "--prefix=#{prefix}/#{arch}"
        system "make", "install"
      end
    end
  end
end
