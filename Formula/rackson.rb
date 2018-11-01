class Rackson < Formula
  desc "HTML generator for rack-mounted IT infrastructures documentation"
  homepage "https://github.com/bpetit/rackson"
  head "https://github.com/bpetit/rackson.git"

  depends_on "python"

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/56/e6/332789f295cf22308386cf5bbd1f4e00ed11484299c5d7383378cf48ba47/Jinja2-2.10.tar.gz"
    sha256 "f84be1bb0040caca4cea721fcbbbbd61f9be9464ca236387158b0feea01914a4"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz"
    sha256 "a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665"
  end

  def install
    xy = Language::Python.major_minor_version "python3"
    ENV["PYTHONPATH"] = libexec/"lib/python#{xy}/site-packages"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{xy}/site-packages"

    resources.each do |r|
      r.stage do
        system "python3", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    # FIXME Work around python3 path assumption; needs upstream PR
    %w[generate.py settings.py].each do |file|
      inreplace file, "#!/usr/bin/python3", "#!/usr/bin/env python3"
    end

    inreplace "generate.py", "abspath('templates')", "'#{pkgshare}/templates'"
    chmod 0755, "generate.py"

    inreplace "generator/generator.py" do |s|
      s.gsub! /(\['libpath'\] = ).*(bootstrap-[^\/]+).*/, "\\1'#{opt_pkgshare}/static/\\2'"

      # FIXME Work around output path mismatch; needs upstream PR
      s.gsub! /^from os.path .*/, '\\0, relpath'
      s.gsub! /(\['outputpath'\] = ).*/, "\\1relpath('.', dirname(target_file))"
    end

    # FIXME Work around JS path mismatch; needs upstream PR
    inreplace "templates/footer.html", /"(js\/[^"]*")/, "\"{{ libpath }}/\\1"

    doc.install %w[data-scheme.mm LICENSE readme.md]
    (etc/"rackson").install "settings.py"
    libexec.install %w[__init__.py generate.py generator]
    ln_s "#{etc}/rackson/settings.py", "#{libexec}/settings.py"
    pkgshare.install "templates"
    (pkgshare/"examples").install "data"
    (pkgshare/"static").install Dir["lib/*"]

    env = {
      :PATH => "#{libexec}/vendor/bin:$PATH",
      :PYTHONPATH => ENV["PYTHONPATH"],
    }
    (bin/"rackson").write_env_script("#{libexec}/generate.py", env)
  end

  def caveats; <<~EOS
    To use rackson:

    1. `cd` to an empty directory.
    2. Bootstrap a `data` subdirectory. For example:
       $ cp -R "#{pkgshare}/examples/data" .
    3. Run `rackson` without arguments.
    4. The result will be in the `output` subdirectory.
  EOS
  end

  test do
    cp_r "#{pkgshare}/examples/data", testpath
    system bin/"rackson"
    assert_predicate testpath/"output/device/index.html", :exist?, "HTML was not generated"
  end
end
