class Cursewords < Formula
  include Language::Python::Virtualenv

  desc "Terminal-based crossword puzzle solving interface"
  homepage "https://github.com/thisisparker/cursewords"
  url "https://files.pythonhosted.org/packages/8b/fb/11a4b2741da1bd6b8dd36a97a8c4bfc23f8762f9a5622e4c9cce8be54c1e/cursewords-1.0.3.tar.gz"
  sha256 "29950b07a5565df0b2ed75061e2cc94bfe1ef0fdb57436845409c82aacd9f77a"

  depends_on "python"

  resource "blessed" do
    url "https://files.pythonhosted.org/packages/51/c7/3af3ec267387d4a900a9e8f9a03a6c9068fb3c606c77bf2dd4558e1ea248/blessed-1.15.0.tar.gz"
    sha256 "777b0b6b5ce51f3832e498c22bc6a093b6b5f99148c7cbf866d26e2dec51ef21"
  end

  resource "puzpy" do
    url "https://files.pythonhosted.org/packages/d1/c6/b227a58fed79acc1996055128009cc1fc8f8d765541b4f8f047cd7a7be82/puzpy-0.2.3.tar.gz"
    sha256 "d37da13e56218ee587baa5e7588c79c415710b16eade2d182923af5a255f8925"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/55/11/e4a2bb08bb450fdbd42cc709dd40de4ed2c472cf0ccb9e64af22279c5495/wcwidth-0.1.7.tar.gz"
    sha256 "3df37372226d6e63e1b1e1eda15c594bca98a22d33a23832a90998faa96bc65e"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"cursewords", "--version"
  end
end
