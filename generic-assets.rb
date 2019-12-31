class GenericAssets < Formula
  desc "Generic assets required to do Measurement Kit development"
  homepage "https://measurement-kit.github.io/"
  version "20191226162429"
  url "https://github.com/measurement-kit/generic-assets/archive/#{version}.tar.gz"
  sha256 "62af9a0c9b22e4b9ded16f00e74774b6b916d0543fd3969bdb3259ec89286b8a"
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
