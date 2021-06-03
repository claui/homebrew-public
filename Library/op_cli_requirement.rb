class OnePasswordCliRequirement < Requirement
  fatal true

  satisfy { which("op") }

  def message
    <<~EOS
      This formula requires 1Password CLI to be installed.
      To install 1Password CLI, run:
        brew install 1password-cli
    EOS
  end

  def display_s
    "1Password CLI"
  end
end
