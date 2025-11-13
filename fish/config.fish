set -gx NVIM "/usr/local/bin/nvim"
set -gx EDITOR "nvim"

# for https://starship.rs/guide/#%F0%9F%9A%80-installation
starship init fish | source

# https://gist.github.com/josh-padnick/c90183be3d0e1feb89afd7573505cab3?permalink_comment_id=3806363#gistcomment-3806363
# Starts SSH agent if it isn't started
if status is-login
  if test -z (pgrep ssh-agent | string collect)
      eval (ssh-agent -c)
      set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
      set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  end

  ssh-add ~/.ssh/github_id_ed25519
end
