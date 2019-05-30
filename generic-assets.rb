class GenericAssets < Formula
  desc "Generic assets required to do Measurement Kit development"
  homepage "https://measurement-kit.github.io/"
  version "20190520205742"
  url "https://github.com/measurement-kit/generic-assets/archive/#{version}.tar.gz"
  sha256 "002ba828a7a5d0cf16116c348d09cd22f00b32a36e61c3b02a40a13e229336c1"
  keg_only "we don't want to install this globally"
  def install
    repoURL = "https://github.com/measurement-kit/generic-assets"
    tarball = "generic-assets-#{version}.tar.gz"
    system "curl", "-fsSLo", "#{tarball}",
      "#{repoURL}/releases/download/#{version}/#{tarball}"
    system "install", "-d", "#{prefix}"
    system "tar", "-C", "#{prefix}", "-xzf", "#{tarball}"
  end
end
