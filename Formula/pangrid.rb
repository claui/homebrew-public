class Pangrid < Formula
  desc "Crossword file format converter"
  homepage "https://github.com/martindemello/pangrid"
  url "https://github.com/martindemello/pangrid/archive/957261755f2a1c0c17a37e0aa52948ed4f5f0d1d.tar.gz"
  version "0.3.1"
  sha256 "cf94da2fcaf56a92120f0b491cae4d9fb9b0887f0459a97da856e1d5e40a6e3a"

  depends_on "ruby" if MacOS.version <= :sierra

  def install
    ENV["GEM_HOME"] = libexec
    system "rake", "gemspec"
    system "gem", "build", "pangrid.gemspec"
    system "gem", "install", "--ignore-dependencies", "pangrid-#{version}.gem"
    bin.install libexec/"bin/pangrid"
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end

  test do
    (testpath/"homebrew.txt").write <<~EOS
      <ACROSS PUZZLE>
      <SIZE>
          4x4
      <GRID>
          ...B
          ...R
          HOME
          ...W
      <ACROSS>
          Where the heart is
      <DOWN>
          To make beer
    EOS

    system "#{bin}/pangrid", "-f", "across-lite-text",
      "-t", "across-lite-binary", "-i", "homebrew.txt",
      "-o", "homebrew.puz"

    assert_equal File.read(testpath/"homebrew.puz"),
      "\x0a\xd8ACROSS&DOWN\0\0HI/\xa6\xd8\x09\x11\xa5Z1.3" +
      "\0" * 17 +
      [
        "\x04\x04\x02",
        "\x01",
        "\0",
        "...B...RHOME...W...-...-----...-",
        "\0",
        "To make beer",
        "Where the heart is",
        "\0",
      ].join("\0")
  end
end
