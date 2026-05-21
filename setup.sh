#!/bin/bash

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
    if [[ -d "/opt/homebrew/bin" ]]; then
        export PATH="/opt/homebrew/bin:${PATH}" # Apple Silicon
    fi

    if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
        export PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}" # Linux
    fi

    brew update
    brew upgrade

    brew install git
    brew install coreutils
    brew install docker
    brew install gnupg
    brew install zsh-autosuggestions

    if [[ "$(uname)" == "Darwin" ]]; then
        brew install orbstack
    fi
}

setup_zsh() {
    echo "Setting up zsh..."

    local remote_git_path="github.com/min0625/setup"
    local local_git_path="${HOME}/src/${remote_git_path}"
    local zshrc_cfg="source ${local_git_path}/zshrc.zsh"
    local local_zshrc_path="${HOME}/.zshrc"

    if [[ ! -d "${local_git_path}" ]]; then
        git clone "https://${remote_git_path}.git" "${local_git_path}"
    fi

    if ! grep -q "^${zshrc_cfg}$" "${local_zshrc_path}"; then
        echo -e "\n${zshrc_cfg}" >>"${local_zshrc_path}"
    fi

    git config --global include.path "~/src/${remote_git_path}/.gitconfig"
    git config --global 'includeIf.gitdir/i:~/src/github.com/.path' "~/src/${remote_git_path}/.gitconfig"
}

setup_mise() {
    echo "Setting up MISE..."

    curl https://mise.run | sh

    export PATH="${PATH}:${HOME}/.local/bin"

    mise use --global go
    mise use --global terraform
    mise use --global kubectl
    mise use --global k9s
    mise use --global uv
    mise use --global bun

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
