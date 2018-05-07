class AmazonUtils < Formula
  desc "Collection of CLI tools to improve UX on Amazon’s retail websites"
  homepage "https://github.com/claui/amazon-utils"
  url "https://github.com/claui/amazon-utils/archive/v0.0.5.tar.gz"
  sha256 "886a4bf71966ac1b4cb25caa6286ea005d5d6982ae62178ddb2d39edd8bd44ee"

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
