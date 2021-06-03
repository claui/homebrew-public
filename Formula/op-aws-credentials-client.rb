require_relative "../Library/op_cli_requirement"

class OpAwsCredentialsClient < Formula
  desc "Password client script to fetch AWS credentials from 1Password"
  homepage "https://github.com/claui"
  url "file:///dev/null"
  version "1.0.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on OnePasswordCliRequirement

  def install
    (bin/"op-aws-credentials-client").write <<~EOS
      #!/bin/bash
      if [ "${SKIP_AWS_SECRET:-0}" -ne '0' ]; then
        printf '\\0'
        exit 0
      fi
      /usr/local/bin/op get item \\
        --fields='Access Key ID,Secret Access Key' \\
        --vault=ekwylbfcpyh3qlpz6ba3dm7e5u \\
        724iu2bgabeungn5d7q4obkche \\
        | /usr/local/bin/jq "$(/bin/cat << EOF
          {
            Version: 1,
            AccessKeyId: ."Access Key ID",
            SecretAccessKey: ."Secret Access Key",
          }
      EOF
          )"
    EOS
  end

  test do
    assert_match(/The account details you entered aren't saved on this device/,
      shell_output("#{bin}/op-aws-credentials-client"))
  end
end
