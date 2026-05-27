# Setup Notes

## Scripts

### Setup (macOS/Linux)

Run this command to bootstrap the environment:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/min0625/setup/HEAD/setup.sh)"
```

> **Linux prerequisites:** `curl` and `git` are required. Homebrew is installed under `/home/linuxbrew/.linuxbrew`.
>
> Install them if missing:
> ```bash
> # Debian / Ubuntu
> sudo apt install -y curl git
> # RHEL / Fedora
> sudo dnf install -y curl git
> ```

## Manual commands

### SSH key

```sh
# Install OpenSSH if needed (usually pre-installed)
brew install openssh

# Generate a new ed25519 SSH key
# See: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
ssh-keygen -t ed25519

# Export the public key for GitHub, GitLab, etc.
cat ~/.ssh/id_ed25519.pub
```

> **Note:** ed25519 is recommended for modern use. Some platforms may still require RSA.
>
> ```bash
> # Generate an RSA SSH key
> ssh-keygen -t rsa -b 4096
>
> # Export the public key for GitHub, GitLab, etc.
> cat ~/.ssh/id_rsa.pub
> ```

### GPG key

```sh
# Install GnuPG if needed (usually pre-installed)
brew install gnupg

# Generate a new GPG key
# See: https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
gpg --full-generate-key

# List public GPG keys
gpg --list-keys --keyid-format=long

# Export the public key in ASCII-armored format
# Replace _YOUR_KEY_ID_ with your actual key ID
gpg --armor --export _YOUR_KEY_ID_
```

## GUI tools

### VSCode

- Install: https://code.visualstudio.com/
- Launch from the command line: https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line

### Fork (Git GUI)

- Install: https://git-fork.com/

### Postman

- Install: https://www.postman.com/downloads/
