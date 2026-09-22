if [[ $(uname) != Darwin ]] && [ -v SSH_AGENT_ENABLED ]; then
    echo ---------- Starting SSH agent ----------
    SSHAGENT=/usr/bin/ssh-agent
    SSHAGENTARGS="-s -t 7200"
    echo existing SSH_AUTH_SOCK: $SSH_AUTH_SOCK
    if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
        SSHAGENTVARS=$($SSHAGENT $SSHAGENTARGS)
        echo $SSHAGENTVARS
        eval $SSHAGENTVARS
        trap "if [[ -n $SSH_AGENT_PID ]] then; kill $SSH_AGENT_PID; echo killed $SSH_AGENT_PID; fi" 0
    fi
    echo
fi

# don't do this at all; require manual trigger via "dotzsh"
# echo ---------- Checking for .zsh updates ----------
# cd ~/.zsh
# # don't do this: security hole
# # git pull
# git fetch --dry-run
# cd ~
# echo

# Re-assert Homebrew's prefix: /etc/zprofile ran path_helper just before this
# file and demoted it behind /usr/bin. Idempotent; see brew-shellenv.
source ~/.zsh/brew-shellenv

source ~/.zprofile.local
