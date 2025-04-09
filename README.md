# My Setup Notes

## Setup For Mac
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/min0625/setup/HEAD/setup.sh)"
```

## Setup Manually

### VSCode
- Install: https://code.visualstudio.com/
- Settings:
    - https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line

### Git GUI Fork
- Install: https://git-fork.com/

### SSH Key
```sh
ssh-keygen -t ed25519 -b 4096
cat ~/.ssh/id_ed25519.pub | pbcopy
```

### GPG Key
```sh
# Install GPG
brew install gnupg

# Generate a new GPG key
# See: https://docs.github.com/zh/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
gpg --full-generate-key

# List GPG public keys
gpg --list-keys

# Copy the GPG public key to clipboard
gpg --armor --export $KEY_ID | pbcopy
```

### Postman
- Install: https://www.postman.com/downloads/
