class Ooniprobe < Formula
  include Language::Python::Virtualenv
  desc "Network interference detection tool (version 2)"
  homepage "https://ooni.org/"
  url "https://files.pythonhosted.org/packages/d8/c0/b4a2ae442dd95160a75251110313d1f9b22834a76ef9bd8f70603b4a867a/ooniprobe-2.3.0.tar.gz"
  sha256 "b4c4a5665d37123b1a30f26ffb37b8c06bc722f7b829cf83f6c3300774b7acb6"
  license "BSD-2-Clause"
  revision 3

  bottle do
    cellar :any
    root_url "https://dl.bintray.com/measurement-kit/homebrew"
    # This is the original bottle from homebrew:
    sha256 "9a5d8c8b6bda3609642113631ba7c39b2cbf4fc27b09bd4b2fccc832befdd3e5" => :catalina
  end

  depends_on "geoip"
  depends_on "libdnet"
  depends_on "libyaml"
  depends_on :macos # Due to Python 2 (Unmaintained, use https://github.com/ooni/probe-cli once out of pre-release)
  depends_on "openssl@1.1"
  depends_on "tor"

  def install
    system "exit", "1"  # We just want to install the bottle
  end

end
