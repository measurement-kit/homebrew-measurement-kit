class GenericAssets < Formula
  desc "Generic assets required to do Measurement Kit development"
  homepage "https://measurement-kit.github.io/"
  version "20190822135402"
  url "https://github.com/measurement-kit/generic-assets/archive/#{version}.tar.gz"
  sha256 "95d3959659d2904d9667a32cd30abbb4ec071472f2da654fdb2895843085c9d8"
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
