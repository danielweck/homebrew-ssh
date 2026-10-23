`sha256sum etc/install-libsk-libfido2-v1.1.5.zsh`
==>
`f832aeee301547fa4ffa653d39c56d42a5585c62fd7d309d702f659eedee0a70`

`sha256sum etc/install-libsk-libfido2-v1.1.6.zsh`
==>
`e9eafe93f5bec473f959aa6a74728b4f49533c3ca87e99112d97562c1a2767e0`

in homebrew core now:

https://github.com/Homebrew/homebrew-core/blob/main/Formula/o/openssh-sk-provider.rb
`brew install openssh-sk-provider`

* `sudo mv /usr/local/lib/libsk-libfido2.dylib /usr/local/lib/libsk-libfido2_DANIEL.dylib`
* `ls -alshFGt --color=auto /usr/local/lib/libsk-libfido2_DANIEL.dylib`
* `sudo cp /opt/homebrew/opt/openssh-sk-provider/lib/sk-libfido2.dylib /usr/local/lib/libsk-libfido2.dylib`
* `sudo chmod a+x /usr/local/lib/libsk-libfido2.dylib`
* `ls -alshFGt --color=auto /usr/local/lib/libsk-libfido2.dylib`

`~/.ssh/config`
```sh
# /opt/homebrew/opt/openssh-sk-provider/lib/sk-libfido2.dylib
# ==>
# /usr/local/lib/libsk-libfido2.dylib
Host github.com
  SecurityKeyProvider /usr/local/lib/libsk-libfido2.dylib
  AddKeysToAgent no
  UseKeychain no
  IdentityFile ~/.ssh/id_ed25519_sk_token2_A
  IdentityFile ~/.ssh/id_ed25519_sk_token2_B
```

# SSH Tools Homebrew Tap

This Homebrew tap provides various SSH-related tools and utilities for macOS.

## Available Formulas

### libsk-libfido2
Library for macOS Yubikey/Token2 support for SSH with FIDO2 security keys. This enables hardware-based SSH authentication using FIDO2/WebAuthn security keys.

**Installation:**
```bash
brew install danielweck/ssh/libsk-libfido2
```

**Post-installation:** Run the following commands to complete setup:
```bash
sudo install-libsk-libfido2
launchctl load /Library/LaunchAgents/com.danielweck.ssh_env_vars.plist
```

**Alternative:** Use the automated cask installer (recommended):
```bash
brew install danielweck/ssh/libsk-libfido2-install
```

## Available Casks

### libsk-libfido2-install
Automated installer for libsk-libfido2 that handles all configuration automatically.

**Installation:**
```bash
brew install danielweck/ssh/libsk-libfido2-install
```

This cask automatically:
- Installs the libsk-libfido2 library
- Configures environment variables
- Sets up launch agents
- Updates shell configuration

## Getting Started

First, add this tap to your Homebrew:
```bash
brew tap danielweck/ssh
```

Then install any of the available tools using the installation commands above.
