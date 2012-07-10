# This is a login session, so start SSH agent and check for .zsh updates before doing anything else.
# Because .profile runs first, .zsh updates to any file except this one should take effect immediately.

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s -t 7200"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "if [[ -n $SSH_AGENT_PID ]] then; kill $SSH_AGENT_PID; fi" 0
fi

echo ---------- Checking for .zsh updates ---------- 
cd ~/.zsh
hg pull; hg update
cd ~
echo

source .zprofile.local