#!/bin/bash

# Exit on any error.
set -eo pipefail

# Print commands if ${TRACE} is set.
[[ "${TRACE}" ]] && set -x

# Exit on unset variables.
set -u

abort() {
    printf "%s\n" "$@" >&2
    exit 1
}

check_is_macos() {
    local os_name="$(uname -s)"

    if [[ "${os_name}" != "Darwin" ]]; then
        abort "unexpected OS: ${os_name}"
    fi
}

command_exist() {
    command -v "${1}" &>/dev/null
}

install_brew() {
    if ! command_exist "brew"; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    brew update
}

brew_cmd() {
    local brew_paths=(
        "brew"
        "/opt/homebrew/bin/brew" # M1
    )

    for brew_path in "${brew_paths[@]}"; do
        if command_exist "${brew_path}"; then
            "$brew_path" "$@"
            return
        fi
    done

    abort "brew command not found"
}

install_brew_pkgs() {
    local brew_pkgs=(
        "git"
        "coreutils"
        "docker"
        "docker-compose"
        "colima"
        "gnupg"
        "trash"
    )

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

# TODO: push config
# TODO: pull config
setup_zsh() {
    local remote_path="github.com/min0625/setup"
    local local_path="${HOME}/src/${remote_path}"
    local zshrc_cfg=". ${local_path}/zshrc.zsh"
    local home_zshrc_path="${HOME}/.zshrc"

    if [[ ! -d "${local_path}" ]]; then
        GIT_CONFIG_GLOBAL=/dev/null \
            git clone "https://${remote_path}.git" "${local_path}"
    fi

    if ! grep -q "^${zshrc_cfg}$" "${home_zshrc_path}"; then
        echo -e "\n${zshrc_cfg}" >>"${home_zshrc_path}"
    fi

    git config --global include.path "~/src/${remote_path}/.gitconfig"
}

# Ref: https://asdf-vm.com/guide/getting-started.html
install_asdf() {
    local local_path="${HOME}/.asdf"

    if [[ ! -d "${local_path}" ]]; then
        GIT_CONFIG_GLOBAL=/dev/null \
            git clone "https://github.com/asdf-vm/asdf.git" "${local_path}" --branch v0.14.0
    fi

    asdf update
}

install_asdf_pkgs() {
    local asdf_pkgs=(
        "golang"
        # "terraform"
        # "kubectl"
        # "k9s"
    )

    for asdf_pkg in "${asdf_pkgs[@]}"; do
        asdf plugin add "${asdf_pkg}"
        asdf install "${asdf_pkg}" latest
        asdf global "${asdf_pkg}" latest
    done
}

setup_asdf() {
    install_asdf
    install_asdf_pkgs
}

main() {
    check_is_macos
    setup_brew
    setup_zsh
    setup_asdf

    echo "Setup completed!!!"
}

main "$@"
