class Rustlings < Formula
  desc "Small exercises to get you used to reading and writing Rust code"
  homepage "https://git.io/rustlings"
  url "https://github.com/rust-lang/rustlings/archive/1.3.0.tar.gz"
  sha256 "6f6fe83cf31d947c91676bd9b219306496dbbcc1c7e1426358389edcb46344cf"

  depends_on "rust" => :build

  patch :p1, :DATA

  def install
    pkgvar = var/"rustlings"
    rm_rf pkgvar/"default_out.txt"
    rm_rf pkgvar/"exercises"
    rm_rf pkgvar/"info.toml"
    pkgvar.install "default_out.txt", "exercises", "info.toml"
    system "cargo", "install", "--root", libexec, "--path", "."

    (bin/"rustlings").write <<~EOS
      #!/bin/bash
      cd "#{pkgvar}" && exec "#{libexec}/bin/rustlings" $@
    EOS
  end

  def caveats; <<~EOS
    Exercises have been installed to:
      #{var}/rustlings

    To reset exercises, run:
      brew reinstall rustlings
  EOS
  end
end
__END__
diff --git a/default_out.txt b/default_out.txt
index 55eaa97..34a33b2 100644
--- a/default_out.txt
+++ b/default_out.txt
@@ -8 +7,0 @@ Let's make sure you're up to speed:
-- You have cloned this repository (https://github.com/rust-lang/rustlings)
@@ -12 +11 @@ Let's make sure you're up to speed:
-cargo install --path .
+brew reinstall rustlings
