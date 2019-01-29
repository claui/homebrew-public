class Znapzupport < Formula
  desc "Collection of CLI helpers for ZnapZend"
  homepage "https://github.com/claui/znapzupport"
  url "https://github.com/claui/znapzupport/archive/v0.1.0.tar.gz"
  sha256 "2bf30370ff01d519bfc057a4da34654566f990a1c0fb86e0de6e1e5f7de7c309"

  bottle :unneeded

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
