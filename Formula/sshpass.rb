class Sshpass < Formula
  desc "Non-interactive ssh password auth"
  homepage "https://sourceforge.net/projects/sshpass"
  url "https://downloads.sourceforge.net/project/sshpass/sshpass/1.09/sshpass-1.09.tar.gz"
  sha256 "71746e5e057ffe9b00b44ac40453bf47091930cba96bbea8dc48717dedc49fb7"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"fake_ssh").write <<~EOS
      #!/bin/bash
      set -eu
      read -ers -p 'Enter password: '
      printf 'The password is %s\n' "${REPLY}"
    EOS
    chmod 0755, testpath/"fake_ssh"

    (testpath/"pw_file").write "hunter2\n"
    output = shell_output("#{bin}/sshpass < #{testpath}/pw_file #{testpath}/fake_ssh")
    assert_equal "The password is hunter2", output.strip
  end
end
