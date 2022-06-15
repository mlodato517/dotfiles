set PATH $PATH $HOME/.cargo/bin

eval (ssh-agent -c)
set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
set -Ux SSH_AGENT_PID $SSH_AGENT_PID
ssh-add ~/.ssh/github_id_ed25519

starship init fish | source

# From sway docs for Fish shell
set TTY1 (tty)
[ "$TTY1" = "/dev/tty1" ] && exec sway

set -gx NVIM "/usr/local/bin/nvim"
set -gx EDITOR "nvim"
