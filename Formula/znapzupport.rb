class Znapzupport < Formula
  desc "Collection of CLI helpers for ZnapZend"
  homepage "https://github.com/claui/znapzupport"
  url "https://github.com/claui/znapzupport/archive/v0.1.3.tar.gz"
  sha256 "db7bbd5b2287a9e501c3933521427da14e26531ad2b16221839f2faa6eb5ae78"

  depends_on "procmail"
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
