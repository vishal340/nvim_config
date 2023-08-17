filetype plugin indent on

let mapleader = " "
let maplocalleader ="\\"

nnoremap <localleader><localleader> :source ~/.config/nvim/init.lua<cr>

"TODO: the line below doesn't work as intended
noremap gft :tabnew <bar> :edit <cfile><cr>

nnoremap gfv :vs <bar> :edit <cfile><cr>
nnoremap gfh :sp <bar> :edit <cfile><cr>
nnoremap <leader>cl :nohlsearch<cr>
nnoremap <F4> :w<cr>
inoremap <F4> <C-o>:w<cr>

nnoremap Y y$

nnoremap <leader><right> :vertical resize +5<cr>
nnoremap <leader><left> :vertical resize -5<cr>
nnoremap <leader><up> :resize +2<cr>
nnoremap <leader><down> :resize -2<cr>
nnoremap <silent><leader>t :let $VIM_DIR=expand('%:p:h')<cr> :40vs <bar> terminal<cr>i cd $VIM_DIR<cr>
nnoremap <silent><leader>T :let $VIM_DIR=expand('%:p:h')<cr> :10sp <bar> terminal<cr>i cd $VIM_DIR<cr>
nnoremap <leader><tab> :tabnew<space>

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

:verbose imap <tab>

"startify
"--------------------------------
autocmd TabNewEntered * if bufname("%") == "" | silent! Startify | endif
nnoremap <silent><leader>s :vs <bar> :Startify<cr>
nnoremap <silent><leader>S :sp <bar> :Startify<cr>
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
