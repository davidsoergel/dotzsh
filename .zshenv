
# Homebrew (Apple Silicon, Intel Mac, or Linux)
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Limits etc.
limit coredumpsize 0 2> /dev/null
umask 022

# Path
typeset -U path # No duplicates
path=( ~/bin /usr/sbin /sbin $path )

typeset -U manpath # No duplicates

# Some environment variables
export LESS=eFRXX
export EDITOR=vim
export VISUAL=vim

# BSD ls (macOS) only
if [[ $(uname) == Darwin ]]; then
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxEgEdAbAgAcEh
fi

source ~/.zshenv.local
