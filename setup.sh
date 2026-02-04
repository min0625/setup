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

brew_cmd() {
    local brew_paths=(
        "/opt/homebrew/bin/brew"              # Apple Silicon
        "/home/linuxbrew/.linuxbrew/bin/brew" # Linux
    )

    local brew_exe=""

    for path in "${brew_paths[@]}"; do
        if [[ -x "${path}" ]]; then
            brew_exe="${path}"
            break
        fi
    done

    if [[ -z "${brew_exe}" ]]; then
        abort "Homebrew is not installed."
    fi

    "${brew_exe}" "$@"
}

setup_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    brew_cmd install git
    brew_cmd install coreutils
    brew_cmd install docker
    brew_cmd install gnupg
    brew_cmd install zsh-autosuggestions

    # brew_cmd install orbstack
}

setup_zsh() {
    local remote_git_path="github.com/min0625/setup"
    local local_git_path="${HOME}/src/${remote_git_path}"
    local zshrc_cfg="source ${local_git_path}/zshrc.zsh"
    local local_zshrc_path="${HOME}/.zshrc"

    echo "Setting up zsh..."

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
    curl https://mise.run | sh

    "${HOME}/.local/bin/mise" use --global go
    "${HOME}/.local/bin/mise" use --global terraform
    "${HOME}/.local/bin/mise" use --global kubectl
    "${HOME}/.local/bin/mise" use --global k9s
}

main() {
    setup_brew
    setup_zsh
    setup_mise

    echo "Setup completed!!!"
}

main "$@"
