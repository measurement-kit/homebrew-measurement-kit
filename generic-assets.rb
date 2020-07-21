class GenericAssets < Formula
  desc "Generic assets required to do Measurement Kit development"
  homepage "https://measurement-kit.github.io/"
  version "20200721121920"

  url "https://github.com/measurement-kit/generic-assets/archive/#{version}.tar.gz"
  sha256 "e9599cb91cdf908edf55b56b3a53c9c64e5bfab8c00b0bb195a8e765559fee52"

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
