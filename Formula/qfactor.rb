class Qfactor < Formula
  desc "Collection of scripts to improve the Quartz WM experience"
  homepage "https://github.com/claui/qfactor"
  url "https://github.com/claui/qfactor/archive/v0.0.1.tar.gz"
  sha256 "934a023c4f63094d4626b624167011d273abb5a7a26a0bcea12164ad66b5584b"

  bottle :unneeded

  depends_on :x11

  def install
    bin_name = "qreload"
    (bin/bin_name).write <<~EOS
      #!/bin/bash
      exec "#{libexec/bin_name}" "$@"
    EOS

    libexec.install [
      "bin/#{bin_name}",
      "libexec/_#{bin_name}.scpt",
    ]

    doc.install "LICENSE.md", "README.md"
  end
end
