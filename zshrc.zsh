# Zsh configuration file

# Locale
export LANG="zh_TW.UTF-8"
# export LANG="en_US.UTF-8"
# export LC_ALL="zh_TW.UTF-8"
# export LC_ALL="en_US.UTF-8"

# Environment
export MIN_ZSHRC_DIR="$(dirname "$(realpath "${0}")")"

# Aliases
alias ls='ls -F --color=auto'
alias ls='gls' # GNU ls
alias ll='ls -l'
alias grep='grep --color'
alias mkdir='mkdir -p'
alias cp='cp -i -r'
alias mv='mv -i'
alias rm='rm -i'
alias python='python3'
alias pip='pip3'
alias k9s='LANG="en_US.UTF-8" k9s' # k9s must be in `en_US.UTF-8` locale.
alias gls='gls -F --color=auto --group-directories-first'
alias docker-compose='docker compose'
alias shell='command'

# Time Format
export TIMEFMT=$'\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# User Local Bin
export PATH="${PATH}:${HOME}/.local/bin"

# Homebrew
export PATH="/opt/homebrew/bin:${PATH}"

# GNU Util
# Install: brew install coreutils
# export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
# export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:${PATH}"

# Prompt
export PROMPT='%F{184}%n%f %F{30}%~%f${vcs_info_msg_0_} %# '

autoload -Uz vcs_info

zstyle ':vcs_info:git:*' formats '%F{1}(%b)%f'

precmd() { vcs_info; }

# Auto Completion
autoload -Uz compinit && compinit -i
# zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors ''

setopt menu_complete # auto select the first completion entry.
setopt prompt_subst
setopt auto_cd
setopt auto_menu # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# Auto Suggestion
# Install: brew install zsh-autosuggestions
source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='underline'
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Docker
# Fix Docker on Apple silicon.
# export DOCKER_DEFAULT_PLATFORM='linux/amd64'
# export DOCKER_DEFAULT_PLATFORM=''

# ASDF
export ASDF_DATA_DIR="${HOME}/.asdf"

export PATH="${ASDF_DATA_DIR}/shims:${PATH}"

# ASDF Completion
fpath=("${ASDF_DATA_DIR}/completions" ${fpath})

# ASDF DirEnv
if [[ -n "$(command -v direnv)" ]]; then
    eval "$(direnv hook zsh)"
fi

# Golang
export GOPATH="${HOME}/go"
export GOMODCACHE="${GOPATH}/pkg/mod"
export GOBIN="${GOPATH}/bin"
export PATH="${PATH}:${GOBIN}"
export GOPRIVATE="github.com/min0625,gitlab.com/min0625"

# setup GOROOT
export ASDF_GOLANG_GOPATH="${GOPATH}"
export ASDF_GOLANG_GOBIN="${GOBIN}"
source "${MIN_ZSHRC_DIR}/set-go-env.zsh"

# AWS V2
# Install: brew install awscli
alias -- aws-sso-login='aws sso login'
alias -- aws.my-core-dev='AWS_PROFILE="my-core-dev" aws'

# GCP
# Install: brew install --cask gcloud-cli
alias -- gcloud-auth-login='gcloud auth login'
alias -- gcloud-auth-revoke='gcloud auth revoke'
alias -- gcloud-auth-login-default='gcloud auth application-default login'
alias -- gcloud-auth-revoke-default='gcloud auth application-default revoke'

# Azure
# Install: brew install azure-cli
alias -- az-login='az login'
