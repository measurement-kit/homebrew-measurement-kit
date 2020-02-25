class GenericAssets < Formula
  desc "Generic assets required to do Measurement Kit development"
  homepage "https://measurement-kit.github.io/"
  version "20200225143707"
  url "https://github.com/measurement-kit/generic-assets/archive/#{version}.tar.gz"
  sha256 "1cb122d2a68bb3ead19d623d21c337588924fe23488a02afaa013daafb70703a"
  keg_only "we don't want to install this globally"
  def install
    repoURL = "https://github.com/measurement-kit/generic-assets"
    for name in ["asn.mmdb", "ca-bundle.pem", "country.mmdb"] do
      gzball = "#{name}.gz"
      system "curl", "-fsSLo", "#{gzball}",
        "#{repoURL}/releases/download/#{version}/#{gzball}"
      system "install", "-d", "#{prefix}"
      system "gunzip", "#{gzball}"
      system "mv", "#{name}", "#{prefix}"
    end
  end
end
