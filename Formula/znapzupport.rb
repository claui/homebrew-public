class Znapzupport < Formula
  desc "Collection of CLI helpers for ZnapZend"
  homepage "https://github.com/claui/znapzupport"
  url "https://github.com/claui/znapzupport/archive/v0.0.6.tar.gz"
  sha256 "5b8666f288c6681ce4dbd896fde3f513a53762a953caea9d7a96ff17807d9cb3"

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
