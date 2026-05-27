#!/bin/bash

# Ensure this script is executed by Bash.
# Use `[` in this initial guard before relying on Bash-specific syntax elsewhere.
if [ -z "${BASH_VERSION-}" ]; then
    printf '%s\n' 'error: this script must be run with bash' >&2
    exit 1
fi

# Abort on any error.
set -eo pipefail

# Abort on undefined variable.
set -u

[[ -n "${TRACE:-}" ]] && set -x

abort() {
    printf "%s\n" "$@" >&2
    exit 1
}

setup_brew() {
    echo "Setting up Homebrew..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Homebrew
    if [[ -x "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else
        abort "brew not found after install"
    fi

    brew update
    brew upgrade

    brew install git
    brew install curl
    brew install coreutils
    brew install docker
    brew install openssh
    brew install gnupg
    brew install zsh-autosuggestions

    if [[ "$(uname)" == "Darwin" ]]; then
        brew install orbstack
    fi
}

setup_zsh() {
    echo "Setting up zsh..."

    local dotfiles_repo="github.com/min0625/setup"
    local dotfiles_dir="${HOME}/src/${dotfiles_repo}"
    local user_zshrc="${HOME}/.zshrc"
    local zshrc_include_line="source ${dotfiles_dir}/zshrc.zsh"
    local dotfiles_gitconfig="${dotfiles_dir}/.gitconfig"

    mkdir -p "$(dirname "${dotfiles_dir}")"
    if [[ ! -d "${dotfiles_dir}" ]]; then
        git clone "https://${dotfiles_repo}.git" "${dotfiles_dir}"
    else
        git -C "${dotfiles_dir}" pull --ff-only
    fi

    touch "${user_zshrc}"
    if ! grep -qFx -- "${zshrc_include_line}" "${user_zshrc}"; then
        # Append a timestamped comment and the source line to the user's ~/.zshrc.
        # This helps users know when the line was added and why it exists.
        local zshrc_comment
        zshrc_comment="# Load min0625 dotfiles (added $(date '+%Y-%m-%d %H:%M:%S'))"
        printf '\n%s\n' "${zshrc_comment}" >> "${user_zshrc}"
        printf '%s\n' "${zshrc_include_line}" >> "${user_zshrc}"
    fi

    git config --global include.path "${dotfiles_gitconfig}"
    git config --global 'includeIf.gitdir/i:~/src/github.com/.path' "${dotfiles_gitconfig}"
}

setup_mise() {
    echo "Setting up MISE..."

    curl -fsSL https://mise.run | sh

    export PATH="${PATH}:${HOME}/.local/bin"

    mise self-update

    mise use --global go
    mise use --global terraform
    mise use --global kubectl
    mise use --global k9s
    mise use --global uv
    mise use --global bun

    mise exec -- uv python install 3.14 --default || true
    mise exec -- uv tool install pre-commit

    # mise use --global node # Install it manually.
}

main() {
    setup_brew
    setup_zsh
    setup_mise

    echo "Setup completed!!!"
}

main "$@"
