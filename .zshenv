
# Limits etc.
limit coredumpsize 0 2> /dev/null
umask 022

# Path
typeset -U path # No duplicates
path=( ~/bin /usr/local/bin /usr/local/sbin /usr/sbin /sbin /usr/local/maven/bin $path )

typeset -U manpath # No duplicates

typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path
ld_library_path=( ~/lib $ld_library_path)

# Some environment variables
export LESS=-X
export CLICOLOR=1
export VISUAL=vim
export CVS_RSH=ssh

export LSCOLORS=ExFxCxDxBxEgEdAbAgAcEh

source ~/.zshenv.local