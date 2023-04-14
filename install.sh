#! /bin/sh

sudo dnf upgrade --refresh

sudo dnf install \
  # Alacritty on Fedora - https://github.com/alacritty/alacritty/blob/master/INSTALL.md#fedora
  cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++ \
  # Better ls
  exa \
  # Better grep
  ripgrep \
  # Neovim
  neovim python3-neovim \
  # Better bash
  fish \
  # Basic i3
  i3 i3status dmenu i3lock \
  # Enable configuring keyboard repeat in X
  xset \
  # We gotta sleep sometime
  redshift \
  # Bluetooth tray in i3
  blueman \
  # Gotta give this a try but I don't have it working yet
  sway


# Setup Neovim
mkdir ~/.config/nvim
cp ./init.vim ~/.config/nvim/
cp ./.vimrc ~/.vimrc

# Setup tmux
cp ./.tmux.conf ~/.tmux.conf

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install alacritty starship
cp ./alacritty.yml ~/.config/alacritty.yml
cp ./starship.toml ~/.config/starship.toml

# https://rust-analyzer.github.io/manual.html#rustup
rustup component add rust-analyzer
ln -s (rustup which --toolchain stable rust-analyzer) ~/.cargo/bin/rust-analyzer

# Setup fish shell
mkdir ~/.config/fish
cp ./fish/config.fish ~/.config/fish/config.fish
cp -r ./fish/functions ~/.config/fish/
chsh -s /usr/bin/fish

# Setup git
git config --global user.email "marklodato0@gmail.com"
git config --global user.name "Mark Lodato"
git config --global core.commentchar "%"
