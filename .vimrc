" FOR VIM-PLUG!!
call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" https://github.com/hrsh7th/nvim-cmp?tab=readme-ov-file#recommended-configuration
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Put your non-Plugin stuff after this line

" Because fish shell
set shell=/bin/bash

" END FOR VIM-PLUG!!

let mapleader = "\<Space>"

" BEGIN neovim-rust

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

lua << EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')
  lspconfig.rust_analyzer.setup {
    -- Server-specific settings. See `:help lspconfig-setup`
    settings = {
      ["rust-analyzer"] = {
          -- enable clippy on save
          check = {
              command = "clippy",
              extraArgs = {"--target-dir", "/home/mlodato/rust-analyzer-check"}
          },
          capabilities = capabilities
      }
    },
  }
EOF

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> [g <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]g <cmd>lua vim.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Autoformat on save
autocmd BufWritePre *.rs lua vim.lsp.buf.format()

" END neovim-rust

" BEGIN TYPESCRIPT

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" END TYPESCRIPT

" FOR EVERYTHING ELSE

set number
"set relativenumber
syntax enable
set expandtab
set shiftwidth=2
set softtabstop=2
set clipboard=unnamedplus

set undodir=~/.vim/undodir
set undofile " Maintain undo history between sessions

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" FOR FZF

" Tell FZF to use RG - so we can skip .gitignore files even if not using
" :GitFiles
"
" I've been getting lots of memory errors when using space + f
" I wonder if it's because of this ... lemme try to not use it for now :shrug:
"
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -s'
nnoremap <leader>f :FZF<cr>
" does this work?
" let g:fzf_layout = { 'window': '-tabnew' }
" If you want gitignored files:
" let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'

" END FZF

noremap <leader>k :call TrimWhiteSpace()<CR>

set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set colorcolumn=100

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

set nowrap

" https://shapeshed.com/vim-statuslines/
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline+=%{StatuslineGit()}
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=\ %l:%c
set statusline+=\ 

" Map 'kj' to Esc so that exits insert mode courtesy of AHalle + ALehmer
inoremap kj <ESC>

" And disable my old way of doing things to help me learn!
inoremap <C-[> <nop>

" https://github.com/rust-lang/rust.vim/issues/198#issuecomment-403266750
" and https://vim.fandom.com/wiki/Fix_syntax_highlighting :shrug:
autocmd BufEnter * :syntax sync fromstart

" Much better tab completion - only tab to first common string. Then require
" other keystrokes.
set wildmode=longest,list,full
set wildmenu

set mouse=

colorscheme vim

" Improve coloring of pop up window
" https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
" Other good ones are 22 and 16. I didn't get very far because 53 is good
" enough for now.
:highlight Pmenu guibg=Black

" END EVERYTHING ELSE
