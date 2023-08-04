filetype plugin indent on


set encoding=utf-8
" set mouse=a
set tabstop=3
set shiftwidth=3
set noexpandtab
set hidden
set ignorecase
set number
set relativenumber
set numberwidth=3
set wildmenu
set scrolloff=1
set history=1000
set belloff=all
set clipboard+=unnamedplus
set timeout 
set timeoutlen=1000 
set ttimeoutlen=200
set updatetime=70
set nobackup
set nowritebackup
set splitright
set splitbelow
set termguicolors
set noswapfile
set path+=**
set modifiable
set autochdir
set completeopt=menu,menuone,noselect
set guicursor=n-v-c:block,i-ci-ve:ver10,r-cr:hor100,o:hor100

let mapleader = " "
let maplocalleader ="\\"

nnoremap <localleader><localleader> :source ~/.config/nvim/init.lua<cr>

" let g:clipboard = {
" 			 \   'name': 'WslClipboard',
" 			 \   'copy': {
" 			 \      '+': 'clip.exe',
" 			 \      '*': 'clip.exe',
" 			 \    },
" 			 \   'paste': {
" 			 \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
" 			 \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
" 			 \   },
" 			 \   'cache_enabled': 0,
" 			 \ }

nmap gf :edit <cfile><cr>
nmap <leader>cl :nohlsearch<cr>


nnoremap Y y$

nnoremap <leader><right> :vertical resize +5<cr>
nnoremap <leader><left> :vertical resize -5<cr>
nnoremap <leader><up> :resize +2<cr>
nnoremap <leader><down> :resize -2<cr>
nnoremap <silent><leader>t :let $VIM_DIR=expand('%:p:h')<cr> :40vs <bar> terminal<cr>i cd $VIM_DIR<cr>
nnoremap <silent><leader>T :let $VIM_DIR=expand('%:p:h')<cr> :10sp <bar> terminal<cr>i cd $VIM_DIR<cr>
nmap <leader><tab> :tabnew<space>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-h> <C-o><C-w>h
inoremap <C-j> <C-o><C-w>j
inoremap <C-k> <C-o><C-w>k
inoremap <C-l> <C-o><C-w>l

" In insert mode, pressing ctrl + numpad's+ increases the font
inoremap <C-kPlus> <Esc>call AdjustFontSize(1)<CR>a
inoremap <C-kMinus> <Esc>:call AdjustFontSize(-1)<CR>a

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <ESC> <C-\><C-n>
vnoremap <leader>y :'<,'>w !xclip -selection clipboard<Cr><Cr>
nnoremap <leader>v <C-v>


inoremap <C-u> <C-o><C-u>
inoremap <C-d> <C-o><C-d>
inoremap <C-b> <C-o><C-b>
inoremap <C-f> <C-o><C-f>

nnoremap gf <C-w>gf

:verbose imap <tab>
"--------------------------------------------------------------------
set viewoptions=cursor,folds,slash,unix
set viewoptions-=options

"startify
"--------------------------------
autocmd TabNewEntered * if bufname("%") == "" | silent! Startify | endif
nnoremap <silent><leader>s :Startify<cr>
 let g:startify_session_dir= '~/.config/nvim/sessions/'

 "the convention used to save session is session name then underscore
 "separated by branch name(if not main branch).
 "before opening the branch first jump to that branch then open it

let g:startify_session_autoload= 0
let g:startify_session_delete_buffers= 0
let g:startify_session_number= 20
let g:startify_session_persistence= 0
let g:startify_files_number= 30
let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ ]

"Luasnip
"----------------------------
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

"markdown
let g:mkdp_browser = '/usr/bin/firefox'
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_command_for_global = 1
let g:mkdp_echo_preview_url = 1
