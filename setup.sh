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

cmd_exist() {
    command -v "${1}" &>/dev/null
}

abort_if_not_mac() {
    [[ -n "${TEST_ON_LINUX:-}" ]] && return 0

    local os_name="$(uname -s)"

    if [[ "${os_name}" != 'Darwin' ]]; then
        abort "Want 'Darwin'(macOS), but got: '${os_name}'"
    fi
}

brew_cmd() {
    local cmd_paths=(
        "brew"
        "/opt/homebrew/bin/brew" # M1
    )

    local local_cmd_path=""
    for cmd_path in "${cmd_paths[@]}"; do
        if cmd_exist "${cmd_path}"; then
            local_cmd_path="${cmd_path}"
            break
        fi
    done

    if [[ -z "${local_cmd_path}" ]]; then
        abort "${FUNCNAME[0]} command not found"
    fi

    "${local_cmd_path}" "$@"
}

asdf_cmd() {
    local cmd_paths=(
        "asdf"
        "/opt/homebrew/bin/asdf"
    )

    local local_cmd_path=""
    for cmd_path in "${cmd_paths[@]}"; do
        if cmd_exist "${cmd_path}"; then
            local_cmd_path="${cmd_path}"
            break
        fi
    done

    if [[ -z "${local_cmd_path}" ]]; then
        abort "${0} command not found"
    fi

    "${local_cmd_path}" "$@"
}

install_brew() {
    if ! cmd_exist "brew"; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "Updating Homebrew..."
    brew update
}

install_brew_pkgs() {
    local brew_pkgs=(
        "git"
        "coreutils"
        "asdf"
        "docker"
        "docker-compose"
        "colima"
        "gnupg"
        "trash"
    )

    echo "Installing Homebrew packages..."

    for brew_pkg in "${brew_pkgs[@]}"; do
        if brew_cmd list "${brew_pkg}" &>/dev/null; then
            brew_cmd upgrade "${brew_pkg}"
        else
            brew_cmd install "${brew_pkg}"
        fi
    done
}

setup_brew() {
    install_brew
    install_brew_pkgs
}

setup_zsh() {
    local remote_git_path="github.com/min0625/setup"
    local local_git_path="${HOME}/src/${remote_git_path}"
    local zshrc_cfg="source ${local_git_path}/zshrc.zsh"
    local local_zshrc_path="${HOME}/.zshrc"

    echo "Setting up zsh..."

    if [[ ! -d "${local_git_path}" ]]; then
        GIT_CONFIG_GLOBAL=/dev/null \
            git clone "https://${remote_git_path}.git" "${local_git_path}"
    fi

    if ! grep -q "^${zshrc_cfg}$" "${local_zshrc_path}"; then
        echo -e "\n${zshrc_cfg}" >>"${local_zshrc_path}"
    fi

    git config --global include.path "~/src/${remote_git_path}/.gitconfig"
    git config --global 'includeIf.gitdir/i:~/src/github.com/.path' "~/src/${remote_git_path}/.gitconfig"
}

install_asdf_pkgs() {
    local asdf_pkgs=(
        "golang"
        "terraform"
        "kubectl"
        "k9s"
        "colima"
        "direnv"
    )

    echo "Installing ASDF packages..."

    for asdf_pkg in "${asdf_pkgs[@]}"; do
        asdf_cmd plugin add "${asdf_pkg}"
        asdf_cmd install "${asdf_pkg}" latest
        asdf_cmd set -u "${asdf_pkg}" latest
    done
}

setup_asdf() {
    install_asdf_pkgs
}

main() {
    abort_if_not_mac
    setup_brew
    setup_zsh
    setup_asdf

    echo "Setup completed!!!"
}

main "$@"
