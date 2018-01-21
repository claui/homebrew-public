class AmazonUtils < Formula
  desc "Collection of CLI tools to improve UX on Amazon’s retail websites"
  homepage "https://github.com/claui/amazon-utils"
  url "https://github.com/claui/amazon-utils/archive/v0.0.1.tar.gz"
  sha256 "09563c347170517b265ff0f2f1e2a2d53d73f6b2ca1a751d19bd10033074429c"

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
