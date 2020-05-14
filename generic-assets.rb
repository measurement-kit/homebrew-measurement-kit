class GenericAssets < Formula
  desc "Generic assets required to do Measurement Kit development"
  homepage "https://measurement-kit.github.io/"
  version "20200514135129"

  url "https://github.com/measurement-kit/generic-assets/archive/#{version}.tar.gz"
  sha256 "7de70a12977abec29840aacd2dcae93be78cc84c45786f5fac5b6cb6dea7c512"

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
