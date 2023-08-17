vim.api.nvim_create_autocmd('BufEnter', {
	command = "if winnr('$') == 1 && bufname() =~ glob2regpat('term:*/bin/bash') | quit | endif",
	nested = true,
})

vim.cmd([[
	augroup vimrc
	  au BufReadPre * setlocal foldmethod=indent
	  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
	augroup END

	if !exists("g:skipview_files")
		 let g:skipview_files = []
	endif
	function! MakeViewCheck()
		 if &l:diff | return 0 | endif
		 if &buftype != '' | return 0 | endif
		 if expand('%') =~ '\[.*\]' | return 0 | endif
		 if empty(glob(expand('%:p'))) | return 0 | endif
		 if &modifiable == 0 | return 0 | endif
		 if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
		 if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif
		 let file_name = expand('%:p')
		 for ifiles in g:skipview_files
			  if file_name =~ ifiles
					return 0
			  endif
		 endfor
		 return 1
	endfunction
	augroup AutoView
		 autocmd!
		 " Autosave & Load Views.
		 autocmd BufWritePre,BufWinLeave ?* if MakeViewCheck() | silent! mkview | endif
		 autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
	augroup END
]])
