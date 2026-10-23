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

...also, Apple TouchID fingerprint reader:

* `sc_auth create-ctk-identity -l ssh -k p-256-ne -t bio`
* `ssh-keychain % sc_auth list-ctk-identities`
* `sc_auth list-ctk-identities -t ssh` (to delete: `sc_auth delete-ctk-identity -h HASH`)
* `ssh-keygen -w /usr/lib/ssh-keychain.dylib -K -N ""` (empty PIN is ok)
* `ls -alshFGt --color=auto id_ecdsa_sk_rk_ssh*`
* `mv id_ecdsa_sk_rk_ssh* ~/.ssh/` (`.pub` and "private" key too ... "private" == placeholder for hardware enclave / security token)
* `cat id_ecdsa_sk_rk_ssh.pub` (upload to GitHub)
* `ssh-copy-id -i id_ecdsa_sk_rk_ssh localhost` + `ssh -o SecurityKeyProvider=/usr/lib/ssh-keychain.dylib localhost` (for SSH localhost)
* `ssh-add -K -S /usr/lib/ssh-keychain.dylib` (for SSH agent, run after reboot)
* `ssh-add -L` (upload to GitHub)

`~/.zshrc` or `~/.zprofile`
```sh
#export SSH_SK_PROVIDER=/usr/local/lib/libsk-libfido2.dylib
export SSH_SK_PROVIDER=/usr/lib/ssh-keychain.dylib
ssh-add -K -S /usr/lib/ssh-keychain.dylib
```

`~/.ssh/config`
```sh
# /opt/homebrew/opt/openssh-sk-provider/lib/sk-libfido2.dylib
# ==>
# /usr/local/lib/libsk-libfido2.dylib

Host github.com

  # export SSH_SK_PROVIDER=/usr/local/lib/libsk-libfido2.dylib
  SecurityKeyProvider /usr/local/lib/libsk-libfido2.dylib

  # export SSH_SK_PROVIDER=/usr/lib/ssh-keychain.dylib
  SecurityKeyProvider /usr/lib/ssh-keychain.dylib

  AddKeysToAgent no
  UseKeychain no

  IdentityFile ~/.ssh/id_ecdsa_sk_rk_ssh_finger
  IdentityFile ~/.ssh/id_ed25519_sk_token2_usbc_github2
  IdentityFile ~/.ssh/id_ed25519_sk_token2_usbc_github

# ssh -T -vvv git@github.com
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
