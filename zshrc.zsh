# export LANG="en_US.UTF-8"
export LANG="zh_TW.UTF-8"
# export LC_ALL="en_US.UTF-8"
# export LC_ALL="zh_TW.UTF-8"

local curr_dir="$(dirname "$(realpath "${0}")")"

alias -- -='cd -'
alias ls='ls -F --color=auto'
alias ls='gls' # GNU ls
alias ll='ls -l'
alias grep='grep --color'
alias mkdir='mkdir -p'
alias cp='cp -i -r'
alias mv='mv -i'
alias rm='rm -i'
alias rm='trash' # brew install trash
alias python='python3'
alias pip='pip3'
alias py='python'
alias k9s='LANG="en_US.UTF-8" k9s' # k9s must be in `en_US.UTF-8` locale.
alias gls='gls -F --color=auto --group-directories-first'
alias docker-compose='docker compose'

# The `time` command output format like `GNU time`
export TIMEFMT=$'\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# Homebrew path for mac M1
export PATH="/opt/homebrew/bin:${PATH}"

export PATH="$PATH:${HOME}/.local/bin"

# GNU Bin Utils
# Install: brew install coreutils
# Info: brew info coreutils
# export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:${PATH}"

# Auto completion
autoload -Uz compinit && compinit -i
# zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors ''

export PROMPT='%F{184}%n%f %F{30}%~%f${vcs_info_msg_0_} %# '

# Show Git info on terminal
autoload -Uz vcs_info

precmd() {
    # Show Git info on terminal
    vcs_info
}

# Show Git info on terminal
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%F{1}(%b)%f'

setopt menu_complete # auto select the first completion entry.
setopt prompt_subst
setopt auto_cd
setopt auto_menu # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# Auto Suggestions
# Install: brew install zsh-autosuggestions
source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='underline'
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# ASDF
export PATH="${ASDF_DATA_DIR:-${HOME}/.asdf}/shims:${PATH}"

# ASDF completions
# append completions to fpath
fpath=("${ASDF_DATA_DIR:-${HOME}/.asdf}/completions" ${fpath})

# ASDF DirEnv
# source "${XDG_CONFIG_HOME:-${HOME}/.config}/asdf-direnv/zshrc"
eval "$(direnv hook zsh)"

# Golang
export GOPATH="${HOME}/go"
export GOMODCACHE="${GOPATH}/pkg/mod"
export GOBIN="${GOPATH}/bin"
export PATH="${PATH}:${GOBIN}"
export GOPRIVATE="github.com/min0625,gitlab.com/min0625"
# set GOROOT
export ASDF_GOLANG_GOPATH="${GOPATH}"
export ASDF_GOLANG_GOBIN="${GOBIN}"
source "${curr_dir}/set-go-env.zsh"

# AWS
# Install: brew install awscli
alias -- aws-sso-login='aws sso login'
alias -- aws.my-core-dev='AWS_PROFILE="my-core-dev" aws'

# GCP
# Install: brew install --cask gcloud-cli
alias -- gcloud-auth-login='gcloud auth login'

# Azure
# Install: brew install azure-cli
alias -- az-login='az login'
