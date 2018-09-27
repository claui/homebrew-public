class AmazonUtils < Formula
  desc "Collection of CLI tools to improve UX on Amazon’s retail websites"
  homepage "https://github.com/claui/amazon-utils"
  url "https://github.com/claui/amazon-utils/archive/v0.0.8.tar.gz"
  sha256 "479fe4427f532a6b1b045352d89f2431aeeedddcec2965a6973ba842848f61d6"

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
