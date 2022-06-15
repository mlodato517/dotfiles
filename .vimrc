
set nocompatible              " be iMproved, required
filetype off                  " required

" FOR VIM-PLUG!!
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-rooter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/vim-emoji'

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

" BEGIN vim-emoji

set completefunc=emoji#complete

" END vim-emoji

" BEGIN coc.nvim

let g:coc_global_extensions = [
  \ 'coc-rust-analyzer',
  \ 'coc-markdownlint',
  \ 'coc-sql',
  \ 'coc-json',
  \ 'coc-prettier',
  \ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>ShowDocumentation()()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Fix text color of rust analyzer popup window in coc.nvim
" https://vi.stackexchange.com/a/24382
hi CocFloating ctermbg=Black

" END coc.nvim

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

" Map 'jk' to Esc so that exits insert mode courtesy of AHalle
inoremap jk <ESC>

" And disable my old way of doing things to help me learn!
inoremap <C-[> <nop>

" https://github.com/rust-lang/rust.vim/issues/198#issuecomment-403266750
" and https://vim.fandom.com/wiki/Fix_syntax_highlighting :shrug:
autocmd BufEnter * :syntax sync fromstart

" Much better tab completion - only tab to first common string. Then require
" other keystrokes.
set wildmode=longest,list,full
set wildmenu

" END EVERYTHING ELSE
