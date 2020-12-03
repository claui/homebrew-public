class SimpleRomManager < Formula
  include Language::Python::Virtualenv

  desc "Verify console and arcade ROMS against published ROM set DAT files"
  homepage "https://github.com/cmcginty/simple-rom-manager"
  url "https://files.pythonhosted.org/packages/56/c0/d1e904a44a436d9ab83c1bd992929a9f73085df08e4a2bb6b803d7d1319b/simple-rom-manager-0.0.5.tar.gz"
  sha256 "18426ddb18ff43730f310b5e38e46bc569d894a9e36ce59d19c9d3d73f8cad87"
  license "MIT"

  depends_on "python@3.9"

  resource "boltons" do
    url "https://files.pythonhosted.org/packages/65/72/87bbce0064894b71f329d285d185f3572893d08bde481b26d9adecf1526d/boltons-17.2.0.tar.gz"
    sha256 "c7496b4b0edfff7e5f27d61da4393fc27fee09c64fa66a423f1e64fa16458a20"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/95/d9/c3336b6b5711c3ab9d1d3a80f1a3e2afeb9d8c02a7166462f6cc96570897/click-6.7.tar.gz"
    sha256 "f15516df478d5a56180fbf80e68f206010e6d160fc39fa508b65e035fd75130b"
  end

  resource "pbr" do
    url "https://files.pythonhosted.org/packages/d5/d6/f2bf137d71e4f213b575faa9eb426a8775732432edb67588a8ee836ecb80/pbr-3.1.1.tar.gz"
    sha256 "05f61c71aaefc02d8e37c0a3eeb9815ff526ea28b3b76324769e6158d7f95be1"
  end

  resource "toml" do
    url "https://files.pythonhosted.org/packages/f5/f9/044110c267e6408013b85166a7cfcd352cf85275aa8ce700aa5c0eb407ba/toml-0.9.4.tar.gz"
    sha256 "8e86bd6ce8cc11b9620cb637466453d94f5d57ad86f17e98a98d1f73e3baab2d"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    touch "#{ENV["HOME"]}/.srmconfig"
    system "#{bin}/srm", "init"
  end
end
