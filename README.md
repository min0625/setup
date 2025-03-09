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

### Docker Colima CLI
- Ref: https://dockerbook.tw/docs/alternatives/colima/
```sh
brew install docker
brew install docker-compose
brew install colima

colima start
colima status
colima stop
```

### SSH Key
```sh
ssh-keygen -t ed25519 -b 4096
cat ~/.ssh/id_ed25519.pub | pbcopy
```

### GPG Key
```sh
brew install gnupg
gpg --full-generate-key
gpg --list-keys
gpg --armor --export $KEY_ID | pbcopy
```
- See: https://docs.github.com/zh/authentication/managing-commit-signature-verification/generating-a-new-gpg-key

### AWS Cli V2
- Install: https://docs.aws.amazon.com/zh_tw/cli/latest/userguide/getting-started-install.html

### Postman
- Install: https://www.postman.com/downloads/
