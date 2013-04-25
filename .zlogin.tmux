# if this is a tmux host session, attach now.
# don't need to detect TMUX because we don't run .zlogin in subshells.

#if [ ! -n "$TMUX" ]
#then

tmux -CC attach

#fi