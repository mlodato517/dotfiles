# dotfiles

Various config files for PC setup

## Vim Plug

This uses vim plug and assumes neovim. Install those first.
Some plugins require other software. The ones I can remember
right now are:

- `fzf`
- `rg`

## Shell

This copies over some FISH specific config files so, if you're not using
FISH, ignore those.

There are also some aliases in here you may need to install things for such as:

- `exa`

## Terminal

This copies over some Alacritty specific config files so, if you're not using
that, ignore those.

The assumed prompt is Starship so you might want that too.

## Brewfile (MacOS)

Install [homebrew-bundle](https://github.com/Homebrew/homebrew-bundle) and run

```sh
brew bundle
```

in the directory with the Brewfile.
