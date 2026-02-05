cask "libsk-libfido2-install" do
  desc "libsk-libfido2 for MacOS Yubikey/Token2 support for SSH"
  homepage "https://github.com/danielweck/homebrew-ssh/"
  version "10.2p1_build2"
  
  url "https://raw.githubusercontent.com/danielweck/homebrew-ssh/main/etc/install-libsk-libfido2-v1.1.5.zsh"
  sha256 "f832aeee301547fa4ffa653d39c56d42a5585c62fd7d309d702f659eedee0a70"
  
  depends_on arch: [:intel, :arm64]
  depends_on formula: "danielweck/ssh/libsk-libfido2"

  postflight do
    system_command "/bin/zsh", args: ["#{staged_path}/install-libsk-libfido2-v1.1.5.zsh"], sudo: true
    system_command "/bin/zsh", args: ["-c", "/bin/launchctl unload /Library/LaunchAgents/com.danielweck.ssh_env_vars.plist &>/dev/null || true"], sudo: false
    system_command "/bin/zsh", args: ["-c", "/bin/launchctl load /Library/LaunchAgents/com.danielweck.ssh_env_vars.plist || true"], sudo: false
    system_command "/bin/zsh", args: ["-c", "echo 'export SSH_SK_PROVIDER=/usr/local/lib/libsk-libfido2.dylib' >> ~/.zshrc || true"], sudo: false
  end

  uninstall_postflight do
    system_command "/bin/zsh", args: ["-c", "rm /usr/local/lib/libsk-libfido2.dylib || true"], sudo: true
    system_command "/bin/zsh", args: ["-c", "/bin/launchctl unload /Library/LaunchAgents/com.danielweck.ssh_env_vars.plist || true"], sudo: false
    system_command "/bin/zsh", args: ["-c", "rm /Library/LaunchAgents/com.danielweck.ssh_env_vars.plist || true"], sudo: true
  end

end
