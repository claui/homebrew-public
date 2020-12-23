class Applyppf < Formula
  desc "Apply Playstation Patch Files"
  homepage "https://netbsd.pkgs.org/9.0/netbsd-aarch64/applyppf-3.0.tgz.html"
  url "https://ftp.netbsd.org/pub/pkgsrc/distfiles/applyppf3_src.zip"
  version "3.0"
  sha256 "49a1be17e1c87a41a85068d23afad3860ede49e61db90d1d086ead036d63eae2"

  def install
    flags = %w[
      -D_LARGEFILE_SOURCE
      -D_FILE_OFFSET_BITS=64
      -D_LARGEFILE64_SOURCE
    ]
    system ENV.cc, "applyppf3_linux.c", "-o", "applyppf", *flags
    bin.install "applyppf"
  end

  test do
    (testpath/"plurals.txt").write "formulas"
    (testpath/"patch.ppf").write(
      "PPF30\2Plural correction#{"\0" * 37}\7#{"\0" * 7}\1e",
    )
    system bin/"applyppf", "a", testpath/"plurals.txt", testpath/"patch.ppf"
    assert_equal "formulae", (testpath/"plurals.txt").read
  end
end
