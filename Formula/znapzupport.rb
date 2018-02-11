class Znapzupport < Formula
  desc "Collection of CLI helpers for ZnapZend"
  homepage "https://github.com/claui/znapzupport"
  url "https://github.com/claui/znapzupport/archive/v0.0.3.tar.gz"
  sha256 "f800c63eff74dacffec4e9ed0c14e9b1d90c19b084cc33d919425e32c4fc63a8"

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
