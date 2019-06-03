class AndroidLibmaxminddb < Formula
  desc "C library for the MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/libmaxminddb/releases/download/1.3.2/libmaxminddb-1.3.2.tar.gz"
  sha256 "e6f881aa6bd8cfa154a44d965450620df1f714c6dc9dd9971ad98f6e04f6c0f0"

  bottle do
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    sha256 "b1444b02f53101098a1668389b92485b0ec8a811df6f8ee0ed60db5cba307042" => :mojave
  end

  depends_on "cross" => :build

  keg_only "Android build that we should not install system wide"

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
