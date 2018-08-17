require "language/node"

class HandshakeFaucetTool < Formula
  desc "Generate Handshake Faucet seeds, keys and addresses"
  homepage "https://gist.github.com/boymanjor/4b44413d5629cc4f8fd0d46b66743b7e"
  url "https://github.com/handshake-org/faucet-tool/archive/v0.1.0.tar.gz"
  sha256 "f44315d036b3acf752ce30c2fde98fa9ae68b76958401977846fe1a23f338212"

  depends_on "node" => :build

  def install
    system "npm", "install", *Language::Node.local_npm_install_args

    system "node_modules/.bin/pkg", "-d",
                                    "-t", "node8-mac",
                                    "--options", "max_old_space_size=4096",
                                    "--out-path", bin,
                                    "bin/faucet-tool"
  end

  test do
    assert_match /\ASeed phrase:\n[\w ]*\n\nAddress:\n\w{42}\n\z/,
                 shell_output("#{bin}/faucet-tool createaddress")
  end
end
