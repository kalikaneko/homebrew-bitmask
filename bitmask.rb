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
  end

  def post_install
    system "echo 'cd /usr/local/Cellar/bitmask/0.10a1 && ./bitmask' > /usr/local/bin/bitmask"
    system "chmod +x /usr/local/bin/bitmask"
    system "mkdir -p /Applications/Bitmask.app/Contents/Resources/bitmask-helper"
    system "cp apps/helpers/openvpn/* /Applications/Bitmask.app/Contents/Resources/"
    system "cp apps/helpers/bitmask-helper /Applications/Bitmask.app/Contents/Resources/bitmask-helper/"
    system "cp apps/helpers/bitmask.pf.conf /Applications/Bitmask.app/Contents/Resources/bitmask-helper/"
    system "cp -r apps/helpers/daemon /Applications/Bitmask.app/Contents/Resources/bitmask-helper/"
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>StandardOutPath</key>
      <string>bitmask-helper.log</string>
      <key>StandardErrorPath</key>
      <string>bitmask-helper-err.log</string>
      <key>GroupName</key>
      <string>daemon</string>
      <key>KeepAlive</key>
      <dict>
	<key>SuccessfulExit</key>
	<false/>
       </dict>
       <key>Label</key>
       <string>se.leap.bitmask-helper</string>
       <key>ProgramArguments</key>
       <array>
         <string>/Applications/Bitmask.app/Contents/Resources/bitmask-helper/bitmask-helper</string>
       </array>
       <key>RunAtLoad</key>
       <true/>
       <key>WorkingDirectory</key>
       <string>/Applications/Bitmask.app/Contents/Resources/bitmask-helper/</string>
       <key>SessionCreate</key>
       <true/>
     </dict>
     </plist>
     EOS
  end

  def caveats; <<-EOS.undent
    This is a precompiled version of Bitmask for testing purposes, and NOT the recommended installation mechanism.
    See https://bitmask.readthedocs.io/
    EOS
  end

  test do
    system "bitmask", "--version"
  end
end
