require_relative "../Library/op_cli_requirement"

class OpAwsCredentialsClient < Formula
  desc "Password client script to fetch AWS credentials from 1Password"
  homepage "https://github.com/claui"
  url "file:///dev/null"
  version "1.0.1"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on OnePasswordCliRequirement

  def install
    (bin/"op-aws-credentials-client").write <<~EOS
      #!/bin/bash -eu
      set -o pipefail

      if [ "${SKIP_AWS_SECRET:-0}" -ne '0' ]; then
        printf '\\0'
        exit 0
      fi

      if [ "${#@}" -lt 4 ]; then
        printf >&2 '%s:\\n\\t%s %s %s %s %s\\n' \\
          'Usage' "$(basename -- "$0")" \\
          '[OP_VAULT]' '[OP_ITEM]' \\
          '[ACCESS_KEY_ID_FIELDNAME]' '[SECRET_ACCESS_KEY_FIELDNAME]' \\
          'Example' "$(basename -- "$0")" \\
          'ha4b0y7mdawmlpp2ywsdke57f7' 'nd9a4myjpgsqdbx4bakqb6aczw' \\
          "'Access Key ID'" "'Secret Access Key'"
        exit 1
      fi

      OP_VAULT="${1?}"
      OP_ITEM="${2?}"
      ACCESS_KEY_ID_FIELDNAME="${3?}"
      SECRET_ACCESS_KEY_FIELDNAME="${4?}"

      /usr/local/bin/op get item \\
        --fields="${ACCESS_KEY_ID_FIELDNAME},${SECRET_ACCESS_KEY_FIELDNAME}" \\
        --vault="${OP_VAULT}" \\
        "${OP_ITEM}" \\
        | /usr/local/bin/jq "$(/bin/cat << EOF
          {
            Version: 1,
            AccessKeyId: ."${ACCESS_KEY_ID_FIELDNAME}",
            SecretAccessKey: ."${SECRET_ACCESS_KEY_FIELDNAME}",
          }
      EOF
          )"
    EOS
  end

  test do
    assert_match(/The account details you entered aren't saved on this device/,
      shell_output("#{bin}/op-aws-credentials-client foo bar baz qux"))
  end
end
