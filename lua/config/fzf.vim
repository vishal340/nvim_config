function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction

let g:fzf_action = {
	\ 'ctrl-q': function('s:build_quickfix_list'),
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-h': 'split',
	\ 'ctrl-x': 'vsplit' }

let g:fzf_history_dir = '~/.local/share/fzf-history'

