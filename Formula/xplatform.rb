class Xplatform < Formula
  desc "Platform-independent aliases for GNU utilities"
  homepage "https://bitbucket.org/clauii/xplatform"
  url "https://bitbucket.org/clauii/xplatform/get/v0.0.11.tar.gz"
  sha256 "94fd9ccb900d6f0adeb360458292863bf7d079c2f70818a977fa6e1b72e03ba8"
  head "https://bitbucket.org/clauii/xplatform.git"

  depends_on "coreutils" => :recommended
  depends_on "findutils" => :recommended
  depends_on "gawk" => :optional # May shadow /usr/bin/awk
  depends_on "gcal" => :recommended
  depends_on "gnu-getopt" => :recommended
  depends_on "gnu-sed" => :recommended
  depends_on "gnu-tar" => :recommended
  depends_on "gpatch" => :optional # May shadow /usr/bin/patch
  depends_on "grep" => :recommended

  def install
    bin_names = [
      "coreutils",
      "findutils",
      ["gawk", :exclude => [/gawk-/]],
      ["gcal", :include => ["mcal"], :exclude => ["gcal2txt"]],
      ["gnu-getopt", :name_prefix => ""],
      "gnu-sed",
      "gnu-tar",
      ["gpatch", :name_prefix => ""],
      "grep",
    ].flat_map do |package_name, options = {}|
      if build.with? package_name
        xplatform_filenames_for(package_name, options)
      else
        []
      end
    end

    bin_names << 'platform_id'

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
    name_prefix = opt.fetch(:name_prefix, "g")
    include_list = opt.fetch(:include, [])
    exclude_list = opt.fetch(:exclude, [])
    filenames = include_list + dir.find.map do |path|
      next if path.directory?
      bin_name = path.basename.to_s
      next if exclude_list.any? { |x| x === bin_name }
      /^#{name_prefix}(.*)/.match(bin_name) { "x#{$1}" }
    end
    filenames.compact
  end

  test do
    if build.with? "coreutils"
      (testpath/"test").write("test")
      (testpath/"test.sha1").write("a94a8fe5ccb19ba61c4c0873d391e987982fbbd3 test")
      system bin/"xsha1sum", "-c", "test.sha1"
      system bin/"xln", "-f", "test", "test.sha1"
    end

    if build.with? "findutils"
      touch "HOMEBREW"
      assert_match "HOMEBREW", shell_output("#{bin}/xfind .")
    end

    if build.with? "gawk"
      assert_match /Foo/, shell_output("#{bin}/xawk 1 <<< Foo")
    end

    if build.with? "gcal"
      date = shell_output("#{bin}/xdate +%Y")
      assert_match(date, shell_output(bin/"xcal"))
    end

    if build.with? "gnu-getopt"
      system bin/"xgetopt", "-o", "--test"
    end

    if build.with? "gnu-sed"
      (testpath/"test.txt").write "Hello world!"
      system bin/"xsed", "-i", "s/world/World/g", "test.txt"
      assert_match /Hello World!/, File.read("test.txt")
    end

    if build.with? "gnu-tar"
      system bin/"xtar", "-c", "-f", testpath/"test.tar.xz",
        "-P", "--no-xattr", "--xz", "/bin/bash"
      assert_match %r{/bin/bash},
        shell_output("#{bin}/xtar -t -f #{testpath}/test.tar.xz -P")
    end

    if build.with? "gpatch"
      (testpath/"test.c").write "#define FOO\n"
      (testpath/"patch").write <<~EOS
        1c1
        < #define FOO
        ---
        > #define BAR
      EOS
      system bin/"xpatch", testpath/"test.c", testpath/"patch"
      assert_match '#define BAR', File.read(testpath/"test.c")
    end

    if build.with? "grep"
      system "#{bin}/xgrep Cafifornia /usr/include/stdlib.h; [ $? -eq 1 ]"
      assert_match /California, Berkeley and its contributors.$/,
        shell_output("#{bin}/xgrep California /usr/include/stdlib.h")
    end
  end
end
