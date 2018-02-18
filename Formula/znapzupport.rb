class Znapzupport < Formula
  desc "Collection of CLI helpers for ZnapZend"
  homepage "https://github.com/claui/znapzupport"
  url "https://github.com/claui/znapzupport/archive/v0.0.8.tar.gz"
  sha256 "820788ca90ccb63bfd17d7060f3f7b00215226e9a05c5b95f08f3c237f0c6e17"

  bottle :unneeded

  depends_on "xplatform"

  def install
    bin_names = %w[znaphodl znaphodlz znaplizt zpoolz]
    bin_names.each do |bin_name|
      (bin/bin_name).write <<~EOS
        #!/bin/bash
        exec "#{libexec/bin_name}" "$@"
      EOS

      libexec.install [
        "bin/#{bin_name}",
        "libexec/#{bin_name}.bash",
      ]
    end

    libexec.install "libexec/dataset_id.bash"

    doc.install "LICENSE.md", "README.md"
  end

  test do
    # No test available yet
  end
end
