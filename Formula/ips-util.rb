class IpsUtil < Formula
  include Language::Python::Virtualenv

  desc "Manipulate IPS patches"
  homepage "https://github.com/nleseul/ips_util"
  url "https://files.pythonhosted.org/packages/e3/68/4250a1ca49778ec7bd00ac408c0cf8a56d09ab8adbfa59f63f14c84d089e/ips_util-1.0.tar.gz"
  sha256 "478502f573f2b92f6409ae9efb129025b9e2cd2d71b2c9b6f1fd1796cb311933"
  license "Unlicense"

  depends_on "python@3.9"

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"old.txt").write "formulas"
    (testpath/"patch.ips").write "PATCH\0\0\a\0\1eEOF"
    system bin/"ips_util", "apply", "--output", testpath/"new.txt",
           testpath/"patch.ips", testpath/"old.txt"
    assert_equal "formulae", (testpath/"new.txt").read
  end
end
