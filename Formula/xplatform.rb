class Xplatform < Formula
  desc "Platform-independent aliases for GNU utilities"
  homepage "https://bitbucket.org/clauii/xplatform"
  url "https://bitbucket.org/clauii/xplatform/get/v0.0.8.tar.gz"
  sha256 "26fbd33bdc35c889b1ed10ac9a16563f78bd8b7900f02499841a828ed3398538"
  head "https://bitbucket.org/clauii/xplatform.git"

  bottle :unneeded

  depends_on "coreutils"
  depends_on "findutils"
  depends_on "gcal"
  depends_on "gnu-getopt"
  depends_on "gnu-sed"
  depends_on "gpatch"

  def install
    bin_names = %w[mcal platform_id]
    bin_names.concat xplatform_filenames_for("coreutils")
    bin_names.concat xplatform_filenames_for("findutils")
    bin_names.concat xplatform_filenames_for("gcal",
      :exclude => ["gcal2txt"])
    bin_names.concat %w[xgetopt] # gnu-getopt
    bin_names.concat xplatform_filenames_for("gnu-sed")
    bin_names.concat %w[xpatch] # gpatch

    bin_names.each do |bin_name|
      (bin/bin_name).write <<~EOS
        #!/bin/bash
        exec "#{libexec/bin_name}" "$@"
      EOS

      libexec.install "bin/#{bin_name}"
    end

    libexec.install [
      "libexec/mcal.bash",
      "libexec/platform_id.bash",
      "libexec/xgetopt.bash",
      "libexec/xpatch.bash",
      "libexec/xplatform_gnu.bash",
      "libexec/xplatform_with_mac_dir.bash",
    ]

    doc.install "LICENSE.md"
  end

  def xplatform_filenames_for(upstream_formula, opt = {})
    dir = Formula[upstream_formula].opt_bin
    exclude_list = opt.fetch(:exclude, [])
    filenames = []
    dir.find do |path|
      next if path.directory?
      bin_name = path.basename.to_s
      next if exclude_list.include?(bin_name)
      bin_name.scan(/^g(.*)/) do |raw_name|
        filenames << "x#{raw_name[0]}"
      end
    end
    filenames.sort
  end

  test do
    # coreutils
    (testpath/"test").write("test")
    (testpath/"test.sha1").write("a94a8fe5ccb19ba61c4c0873d391e987982fbbd3 test")
    system bin/"xsha1sum", "-c", "test.sha1"
    system bin/"xln", "-f", "test", "test.sha1"

    # findutils
    touch "HOMEBREW"
    assert_match "HOMEBREW", shell_output("#{bin}/xfind .")

    # gcal
    date = shell_output("#{bin}/xdate +%Y")
    assert_match(date, shell_output(bin/"xcal"))

    # gnu-getopt
    system bin/"xgetopt", "-o", "--test"

    # gnu-sed
    (testpath/"test.txt").write "Hello world!"
    system bin/"xsed", "-i", "s/world/World/g", "test.txt"
    assert_match /Hello World!/, File.read("test.txt")
  end
end
