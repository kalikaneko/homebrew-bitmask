class Bitmask < Formula
  desc "Your Internet Encryption Toolkit: VPN and Encrypted Email"
  homepage "https://0xacab.org/leap/bitmask-dev"

  # CHANGE-ME -------------------------------------------------------------
  version "0.10a1p3"
  sha256 "d662c7e86087aa6ef6b6917248d15558c6e91a436facaa524a4000eab3693a36"
  # -----------------------------------------------------------------------

  url "https://downloads.leap.se/client/osx/internal/bitmask-" + version + ".tar.gz"

  depends_on "openvpn" => :run
  depends_on "gpg" => :run

  bottle :unneeded

  def install
    prefix.install Dir["*"]
    system "echo 'cd /usr/local/Cellar/bitmask/" + version + " && ./bitmask' > /usr/local/bin/bitmask"
    system "chmod +x /usr/local/bin/bitmask"
    system "mkdir -p /Applications/Bitmask.app/Contents/Resources/bitmask-helper"
  end

  def post_install
    system "cp #{prefix}/apps/helpers/openvpn/* /Applications/Bitmask.app/Contents/Resources/"
    system "cp #{prefix}/apps/helpers/bitmask-helper /Applications/Bitmask.app/Contents/Resources/bitmask-helper/"
    system "cp #{prefix}/apps/helpers/bitmask.pf.conf /Applications/Bitmask.app/Contents/Resources/bitmask-helper/"
    system "cp -r #{prefix}/apps/helpers/daemon/daemon.py /Applications/Bitmask.app/Contents/Resources/bitmask-helper/"
    system "sudo cp -r #{prefix}/apps/helpers/se.leap.bitmask-helper.plist /Library/LaunchDaemons/"
    system "sudo launchctl unload /Library/LaunchDaemons/se.leap.bitmask-helper.plist" || true
    system "sudo launchctl load /Library/LaunchDaemons/se.leap.bitmask-helper.plist" || true
  end

  def caveats; <<-EOS.undent
    This is a precompiled version of Bitmask for testing purposes, and NOT the recommended installation mechanism. See https://bitmask.readthedocs.io/ for moar info :)
    EOS
  end

  test do
    system "bitmask", "--version"
  end
end
