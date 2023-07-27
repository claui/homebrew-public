class HopperSdk < Formula
  desc "Hopper SDK"
  homepage "https://www.hopperapp.com/download/"
  url "https://d2ap6ypl1xbe4k.cloudfront.net/HopperSDK-4.5.11.zip"
  sha256 "10f3c5fd44038245042a350308774d57b2b53f7485ecdc2139900ee91d8aa86c"

  def install
    include.install "include/Hopper"
    (pkgshare/"examples").install Dir["Samples/*"]
    doc.install "SDK Documentation.pdf"

    (bin/"hopper-sdk").write <<~EOS
      #!/bin/bash
      exec open "#{doc}/SDK Documentation.pdf"
    EOS
  end
end
