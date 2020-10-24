# for rbenv!
status --is-interactive; and source (rbenv init -|psub)

# for keychain!
eval (ssh-agent -c)

set PATH $PATH $HOME/.cargo/bin

set -gx NVIM "/usr/local/bin/nvim"
set -gx EDITOR "nvim"
set -g fish_user_paths "/usr/local/opt/gettext/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/node@12/bin" $fish_user_paths
