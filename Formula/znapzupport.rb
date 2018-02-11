class Znapzupport < Formula
  desc "Collection of CLI helpers for ZnapZend"
  homepage "https://github.com/claui/znapzupport"
  url "https://github.com/claui/znapzupport/archive/v0.0.2.tar.gz"
  sha256 "67d6781f156f4befc25a7417897fcdc7ea5fcae102fbcc1852c2d23dae36cf44"

  bottle :unneeded

  def install
    bin_name = "znaphodl"
    (bin/bin_name).write <<~EOS
      #!/bin/bash
      exec "#{libexec/bin_name}" "$@"
    EOS

    libexec.install [
      "bin/#{bin_name}",
      "libexec/#{bin_name}.bash",
    ]

    doc.install "LICENSE.md", "README.md"
  end

  test do
    # No test available yet
  end
end
