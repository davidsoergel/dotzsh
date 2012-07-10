# These aliases are needed in tmux subshells to propagate the current ssh-agent even after reattachment.

alias ssh='source ~/.zsh/updatessh; ssh'
alias hg='source ~/.zsh/updatessh; hg'
alias scp='source ~/.zsh/updatessh; scp'
alias ssh-add='source ~/.zsh/updatessh; ssh-add'