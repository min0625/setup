if [[ "${0}" == "${BASH_SOURCE}" ]]; then
    echo "This script should be sourced, not executed."
    exit 1
fi

## Homebrew M1
PATH="/opt/homebrew/bin:$PATH"

# GNU Bin Utils
# Install: brew install coreutils
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# Alias
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias grep='grep --color'
alias python='python3'
alias pip='pip3'
alias py='python'

## myself ENV
if [[ -f "$HOME/.myself.env" ]]; then
    . $HOME/.myself.env
else
    touch $HOME/.myself.env
fi

# Auto Complete
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu yes select

# Show some info on terminal
PROMPT='%F{184}%n%f@%F{2}%m%f %F{30}%~%f
%# '

# Show Git info on terminal
RPROMPT='${vcs_info_msg_0_}'

# Show Git info on terminal
autoload -Uz vcs_info

precmd() {
    # echo "Current time: $(date)"

    # Show Git info on terminal
    vcs_info
}

# Show Git info on terminal
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%F{1}(%b)%f'

# Show Git info on terminal.
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST

# ASDF
# Ref: https://asdf-vm.com/guide/getting-started.html
. "$HOME/.asdf/asdf.sh"

# Golang with ASDF
#
# Ref: https://github.com/asdf-community/asdf-golang
#
# setup ${GOROOT}
. "$HOME/.asdf/plugins/golang/set-env.zsh"
#
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export GOPRIVATE="github.com/min0625,gitlab.kkinternal.com"

# AWS
# AWS_PROFILE="pgc-core-dev"
alias aws.pgc_core_dev='AWS_PROFILE="pgc-core-dev" aws'
