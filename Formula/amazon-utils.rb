class AmazonUtils < Formula
  desc "Collection of CLI tools to improve UX on Amazon’s retail websites"
  homepage "https://github.com/claui/amazon-utils"
  url "https://github.com/claui/amazon-utils/archive/v0.0.4.tar.gz"
  sha256 "e0a9b2585e90204a94c955f3c0560ea0d23a849531221d95d909e15a9ddd097f"

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
