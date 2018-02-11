class Znapzupport < Formula
  desc "Collection of CLI helpers for ZnapZend"
  homepage "https://github.com/claui/znapzupport"
  url "https://github.com/claui/znapzupport/archive/v0.0.1.tar.gz"
  sha256 "56849edc69056f07ebda4945c5eeda728c115ba986e658c65eded4313034c8a9"

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
