if [[ -n $SSH_AGENT_PID ]] then
  echo "killing ssh agent [${SSH_AGENT_PID}]"
  ssh-add -D
  kill $SSH_AGENT_PID
  unset SSH_AGENT_PID
  unset SSH_AUTH_SOCK
fi               
