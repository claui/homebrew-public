class OnepasswordCliBeta < Formula
  desc "1Password command-line interface, public beta"
  homepage "https://app-updates.agilebits.com/product_history/CLI"
  url "https://cache.agilebits.com/dist/1P/op/pkg/v0.2/op_darwin_amd64_v0.2.zip"
  sha256 "a3d36a67fa3cdd6c6869d2c0e3d2d369e75a1f6ce3724454f467db0944c7a8ba"

  def install
    bin.install "op"
    pkgshare.install "op.sig"
  end

  def caveats; <<~EOS
    To verify AgileBits’s signature, run one of the following:

      gpg --verify \\
        #{HOMEBREW_PREFIX}/share/onepassword-cli-beta/op.sig \\
        "$(which op)"

    or alternatively:

      keybase pgp verify \\
        -d #{HOMEBREW_PREFIX}/share/onepassword-cli-beta/op.sig \\
        -i "$(which op)" -S 1password
    EOS
  end

  test do
    assert_equal "#{version}\n",
      shell_output("#{bin}/op --version")
  end
end
