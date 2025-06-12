# Ref: https://github.com/asdf-community/asdf-golang/blob/962a601cbdeb7ea9bc18afb5879bfe5d0b47d307/set-env.zsh

asdf_update_golang_env() {
  local go_bin_path
  go_bin_path="$(asdf which go 2>/dev/null)"
  if [[ -n "${go_bin_path}" ]]; then
    export GOROOT
    GOROOT="$(dirname "$(dirname "${go_bin_path:A}")")"

    export GOPATH
    if [[ -n "${ASDF_GOLANG_GOPATH}" ]]; then
      GOPATH="${ASDF_GOLANG_GOPATH}"
    else
      GOPATH="$(dirname "${GOROOT:A}")/packages"
    fi

    export GOBIN
    if [[ -n "${ASDF_GOLANG_GOBIN}" ]]; then
      GOBIN="${ASDF_GOLANG_GOBIN}"
    else
      GOBIN="$(dirname "${GOROOT:A}")/bin"
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd asdf_update_golang_env
