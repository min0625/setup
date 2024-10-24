export LANG="zh_TW.UTF-8"
export LC_ALL="zh_TW.UTF-8"

export TIMEFMT=$'\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

## Homebrew M1
export PATH="/opt/homebrew/bin:${PATH}"

# GNU Bin Utils
# Install: brew install coreutils
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:${PATH}"

# Alias
alias -- -='cd -'
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias grep='grep --color'
alias mkdir='mkdir -p'
alias cp='cp -i -r'
alias mv='mv -i'
# alias rm='rm -i'
alias rm='trash' # brew install trash
alias python='python3'
alias pip='pip3'
alias py='python'

## myself ENV
if [[ -f "${HOME}/.myself.env" ]]; then
    . "${HOME}/.myself.env"
else
    touch "${HOME}/.myself.env"
fi

# Auto Complete
autoload -Uz compinit && compinit -i
# zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors ''

# Show some info on terminal
export PROMPT='%F{184}%n%f@%F{2}%m%f %F{30}%~%f
%# '

# Show Git info on terminal
export RPROMPT='${vcs_info_msg_0_}'

# Show Git info on terminal
autoload -Uz vcs_info

precmd() {
    # Show Git info on terminal
    vcs_info
}

# Show Git info on terminal
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%F{1}(%b)%f'

unsetopt menu_complete # do not autoselect the first completion entry
setopt prompt_subst
setopt auto_cd
setopt auto_menu # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# ASDF
# Ref: https://asdf-vm.com/guide/getting-started.html
. "${HOME}/.asdf/asdf.sh"

# Golang with ASDF
#
# Ref: https://github.com/asdf-community/asdf-golang
#
# setup ${GOROOT}
. "${HOME}/.asdf/plugins/golang/set-env.zsh"
#
export GOPATH="${HOME}/go"
export PATH="${PATH}:${GOPATH}/bin"
export GOPRIVATE="github.com/min0625,gitlab.kkinternal.com"

# MySQL Client
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"

# AWS
# AWS_PROFILE="pgc-core-dev"
alias aws.pgc_core_dev='AWS_PROFILE="pgc-core-dev" aws'

alias k9s='LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8" k9s'
