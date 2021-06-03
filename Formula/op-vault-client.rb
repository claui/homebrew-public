require_relative "../Library/op_cli_requirement"

class OpVaultClient < Formula
  desc "Password client script to integrate Ansible Vault with 1Password"
  homepage "https://github.com/claui"
  url "file:///dev/null"
  version "1.0.2"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on OnePasswordCliRequirement

  def install
    (bin/"op-vault-client").write <<~EOS
      #!/bin/bash
      if [ "${SKIP_VAULT_PASSWORD:-0}" -ne '0' ]; then
        printf '\\0'
        exit 0
      fi
      op get item --vault=iic4muvgtwosr67kogwh4q7t2a \\
        owerpe2tcbemjou3wyauz3bd5y --fields password
    EOS
  end

  test do
    assert_match(/The account details you entered aren't saved on this device/,
      shell_output("#{bin}/op-vault-client"))
  end
end
