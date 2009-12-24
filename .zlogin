SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s -t 7200"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "if [[ -n $SSH_AGENT_PID ]] then; kill $SSH_AGENT_PID; fi" 0
fi
