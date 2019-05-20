class Img4lib < Formula
  desc "Image4 VFS"
  homepage "https://github.com/xerub/img4lib"
  # pull from git revision to get submodules
  head "https://github.com/xerub/img4lib.git",
      :revision => "26b0709c68efe1ec3cd9c491635810ad3f657b45"

  def install
    inreplace "Makefile", /^.*\b(COMMONCRYPTO)\b =.*/, "\\1 = 1"
    system "make", "-C", "lzfse"
    system "make"
    bin.install "img4"
  end
end
