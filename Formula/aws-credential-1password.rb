require_relative "../Library/op_cli_requirement"

class AwsCredential1password < Formula
  desc "AWS credentials helper for 1Password vaults"
  homepage "https://github.com/claui/aws-credential-1password"
  url "https://github.com/claui/aws-credential-1password/archive/refs/tags/v0.2.tar.gz"
  sha256 "15b7efd53bc203d0c3c7743b40154eecbaa75b414a9b72edc8aff94d791e62cc"
  version_scheme 1

  depends_on "jq"
  depends_on OnePasswordCliRequirement

  def install
    bin.install "aws-credential-1password"
    doc.install [
      "LICENSE",
      "README.md",
    ]
  end

  def caveats
    <<~EOS
      For consistency with other packages, this binary has been renamed.
      Change all your usages from:

        op-aws-credentials-client

      to:

        aws-credential-1password
    EOS
  end

  test do
    _, stderr, = Open3.capture3("#{bin}/aws-credential-1password")
    assert_match(/Usage:\n\taws-credential-1password/, stderr)
  end
end
