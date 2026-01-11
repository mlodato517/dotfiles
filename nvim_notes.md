# Steps for setting up Nvim "ground up"

## Tasks

- LSP Config
    - Popups for error diagnostics and docs
    - Hotkeys for code actions, renames, go to definition, etc.
- Fuzzy file search
- Syntax highlighting

## LSP Config

Starting at [the rust analyzer docs][rust-analyzer], I installed
[`nvim-lspconfig`][nvim-lspconfig] using the `git clone` option. Then, in
`~/.config/nvim/init.lua` I did:

```lua
vim.lsp.enable('rust_analyzer')
```

Then opened a rust file and checked with:

```vim
:checkhealth vim.lsp
```

This gave me a decent start (maybe from [here][default_rls_1]). Haven't started [this][default_rls_2] yet, but should!

[nvim-lspconfig]: https://github.com/neovim/nvim-lspconfig/tree/master?tab=readme-ov-file#install
[rust-analyzer]: https://rust-analyzer.github.io/book/other_editors.html#nvim-lsp 
[default_rls_1]: https://github.com/neovim/nvim-lspconfig/blob/92ee7d42320edfbb81f3cad851314ab197fa324a/lsp/rls.lua
[default_rls_2]: https://github.com/neovim/nvim-lspconfig/blob/92ee7d42320edfbb81f3cad851314ab197fa324a/lsp/rust_analyzer.lua
