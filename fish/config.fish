set -gx NVIM "/usr/local/bin/nvim"
set -gx EDITOR "nvim"

# Sourcing ~/.cargo/env doesn't work for Fish?
# See https://github.com/rust-lang/rustup/issues/478#issuecomment-331625472
set PATH $HOME/.cargo/bin $PATH

# for https://starship.rs/guide/#%F0%9F%9A%80-installation
starship init fish | source

# https://gist.github.com/josh-padnick/c90183be3d0e1feb89afd7573505cab3?permalink_comment_id=3806363#gistcomment-3806363
if test -z (pgrep ssh-agent | string collect)
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    # ssh-add ~/.ssh/path_to_private_key
end
