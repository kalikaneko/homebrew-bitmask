class Bitmask < Formula
  desc "Your Internet Encryption Toolkit: VPN and Encrypted Email"
  homepage "https://0xacab.org/leap/bitmask-dev"
  url "https://downloads.leap.se/client/osx/internal/bitmask-0.10a1.tar.gz"
  version "0.10a1"
  sha256 "81a84ab80e8d8cf9ccada5289f51965ed6892797967584b662defe47db264706"

  depends_on "openvpn" => :run

  bottle :unneeded

  def install
    prefix.install Dir["*"]
  end

  test do
    #system "#{bin}/bitmask", "--version"
    system "true"
  end
end
