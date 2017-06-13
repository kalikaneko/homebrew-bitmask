class Bitmask < Formula
  desc "Your Internet Encryption Toolkit: VPN and Encrypted Email"
  homepage "https://0xacab.org/leap/bitmask-dev"
  url "https://downloads.leap.se/client/osx/internal/bitmask-0.10a1.tar.gz"
  version "0.10a1"
  sha256 "d06f753984c224aac3396386c1494bfd5795c3145e9099519e4994b3af5947f2"

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
    system "cp -r #{prefix}/apps/helpers/daemon/daemon.py /Applications/Bitmask.app/Contents/Resources/bitmask-helper/"
    system "sudo cp -r #{prefix}/apps/helpers/se.leap.bitmask-helper.plist /Library/LaunchDaemons/"
  end

  def post_install
    system "sudo launchctl load /Library/LaunchDaemons/se.leap.bitmask-helper.plist"
  end

  def caveats; <<-EOS.undent
    This is a precompiled version of Bitmask for testing purposes, and NOT the recommended installation mechanism. See https://bitmask.readthedocs.io/ for moar info :)
    EOS
  end

  test do
    system "bitmask", "--version"
  end
end
