# Agent Instructions

This is a personal developer dotfiles/setup repository targeting macOS (and Linux).

## Key Files

| File | Purpose |
|------|---------|
| [setup.sh](setup.sh) | Bootstrap script: installs Homebrew, configures zsh, installs mise and tools |
| [zshrc.zsh](zshrc.zsh) | Zsh config: locale, aliases, prompt, completion |
| [.gitconfig](.gitconfig) | Git global include config used by `setup.sh` |
| [.pre-commit-config.yaml](.pre-commit-config.yaml) | Pre-commit configuration used by `make check` |
| [.devcontainer/](.devcontainer/) | Dev container configuration and post-create script |
| [aws_config.sample](aws_config.sample) | AWS SSO config template (copy to `~/.aws/config`) |
| [Makefile](Makefile) | `make check` runs pre-commit on all files |

## Build / Lint

```sh
make check   # runs: pre-commit run --show-diff-on-failure --color=always --all-files
```

## Shell Script Conventions

- Scripts that rely on Bash-specific behavior from the start should begin with a Bash version guard (see `setup.sh`)
- Always use `set -eo pipefail` and `set -u`
- Support `TRACE=1` for debug output via `[[ -n "${TRACE:-}" ]] && set -x`
- Use `[[ ]]` for conditionals when writing Bash-targeted scripts
- Indent shell scripts with spaces; this repo uses `pre-commit` + `shfmt -i 4 -kp` for formatting

## Managed Tools (via [mise](https://mise.jdx.dev/))

go, terraform, kubectl, k9s, uv, bun

## Locale

Default locale is `zh_TW.UTF-8` (see `zshrc.zsh`).
