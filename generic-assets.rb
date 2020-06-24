class GenericAssets < Formula
  desc "Generic assets required to do Measurement Kit development"
  homepage "https://measurement-kit.github.io/"
  version "20200619115947"

  url "https://github.com/measurement-kit/generic-assets/archive/#{version}.tar.gz"
  sha256 "93d4de4d4b46e5b935ef007015370d576476ff6b5088c31571c9dafbf28ef8cc"

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
