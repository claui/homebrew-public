class AmazonUtils < Formula
  desc "Collection of CLI tools to improve UX on Amazon’s retail websites"
  homepage "https://github.com/claui/amazon-utils"
  url "https://github.com/claui/amazon-utils/archive/v0.0.3.tar.gz"
  sha256 "5701b880d6583a8b3012e7dcb3bbaefb9e6053eb8babd6525ec93dab5a010f6b"

  bottle :unneeded

  def install
    system "make"

    bin_name = "amazon-chat"
    (bin/bin_name).write <<~EOS
      #!/bin/bash
      exec "#{libexec/bin_name}" "$@"
    EOS

    libexec.install [
      "bin/#{bin_name}",
      "libexec/#{bin_name}.scpt",
    ]

    doc.install "LICENSE.md", "README.md"
  end

  test do
    # No test available that would not have unacceptable side effects
  end
end
