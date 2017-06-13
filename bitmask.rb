class Bitmask < Formula
  desc "Your Internet Encryption Toolkit: VPN and Encrypted Email"
  homepage "https://0xacab.org/leap/bitmask-dev"
  url "https://downloads.leap.se/client/osx/internal/bitmask-0.10a1.tar.gz"
  version "0.10a1"
  sha256 "c1e987ec1431a6418c8a9c90e1410b871066915a12a8979c3fa1b71e4876fa15"

  depends_on "openvpn" => :run

  bottle :unneeded

  def install
    prefix.install Dir["*"]
    system "echo 'cd /usr/local/Cellar/bitmask/0.10a1 && ./bitmask' > /usr/local/bin/bitmask"
    system "chmod +x /usr/local/bin/bitmask"
    system "mkdir -p /Applications/Bitmask.app/Contents/Resources/bitmask-helper"
    system "cp #{prefix}/apps/helpers/openvpn/* /Applications/Bitmask.app/Contents/Resources/"
    system "cp #{prefix}/apps/helpers/bitmask-helper /Applications/Bitmask.app/Contents/Resources/bitmask-helper/"
    system "cp #{prefix}/apps/helpers/bitmask.pf.conf /Applications/Bitmask.app/Contents/Resources/bitmask-helper/"
    system "cp -r #{prefix}/apps/helpers/daemon /Applications/Bitmask.app/Contents/Resources/bitmask-helper/"
    system "sudo cp -r #{prefix}/apps/helpers/se.leap.bitmask-helper.plist /Library/LaunchDaemons/"
  end

  def post_install
    system "sudo" "launchctl" "load" "/Library/LaunchDaemons/se.bitmask-helper.plist"
  end

  def caveats; <<-EOS.undent
    This is a precompiled version of Bitmask for testing purposes, and NOT the recommended installation mechanism. See https://bitmask.readthedocs.io/ for moar info :)
    EOS
  end

  test do
    system "bitmask", "--version"
  end
end
