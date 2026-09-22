
# Homebrew (Apple Silicon, Intel Mac, or Linux).
# NOTE: on macOS this is undone by path_helper in /etc/zprofile, so the same
# file is sourced again from .zprofile. See the comments in brew-shellenv.
source ~/.zsh/brew-shellenv

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
