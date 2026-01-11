-- Always set leader first!
-- https://github.com/jonhoo/configs/blob/7bd6806cf55b2033c4d957c0bdafc54dde7ec2dc/editor/.config/nvim/init.lua
-- vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-- BEGIN LSP STUFF

vim.lsp.enable('rust_analyzer')
-- Need to figure out this silent stuff...
vim.keymap.set('n', '<silent> <c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<silent> K',     '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<silent> gD',    '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', '<silent> <c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.set('n', '<silent> 1gD',   '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', '<silent> gr',    '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<silent> g0',    '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
vim.keymap.set('n', '<silent> gW',    '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
vim.keymap.set('n', '<silent> gd',    '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<leader>rn',     '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<silent> ga',    '<cmd>lua vim.lsp.buf.code_action()<CR>')

-- END LSP STUFF
-- BEGIN MY STUFF

vim.cmd.colorscheme('wildcharm')

-- Map 'kj' to Esc so that exits insert mode courtesy of AHalle + ALehmer.
vim.keymap.set('i', 'kj', '<ESC>')

vim.opt.number = true
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'

vim.opt.undodir = '~/.vim/undodir'
-- Maintain undo history between sessions
vim.opt.undofile = true

-- END MY STUFF
