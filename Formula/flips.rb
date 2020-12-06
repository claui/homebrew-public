class Flips < Formula
  desc "Patcher for IPS and BPS files"
  homepage "https://github.com/Alcaro/Flips"
  head "https://github.com/Alcaro/Flips.git"
  license "GPL-3.0"

  def install
    system "make", "PREFIX=#{prefix}"
    bin.install "flips"
  end

  test do
    (testpath/"old.txt").write "formulas"
    (testpath/"patch.ips").write "PATCH\0\0\a\0\1eEOF"
    output = shell_output("#{bin}/flips --apply #{testpath}/patch.ips #{testpath}/old.txt #{testpath}/new.txt")
    assert_equal "The patch was applied successfully!\n", output
    assert_equal "formulae", (testpath/"new.txt").read
  end
end
