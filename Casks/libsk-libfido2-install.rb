cask "libsk-libfido2-install" do
  desc "libsk-libfido2 for MacOS Yubikey/Token2 support for SSH"
  homepage "https://github.com/danielweck/homebrew-ssh/"
  version "10.2p1_build4"

  url "https://raw.githubusercontent.com/danielweck/homebrew-ssh/main/etc/install-libsk-libfido2-v1.1.6.zsh"
  sha256 "e9eafe93f5bec473f959aa6a74728b4f49533c3ca87e99112d97562c1a2767e0"

  depends_on arch: [:intel, :arm64]
  depends_on formula: "danielweck/ssh/libsk-libfido2"

  postflight do
    system_command "/bin/zsh", args: ["#{staged_path}/install-libsk-libfido2-v1.1.6.zsh"], sudo: true
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
