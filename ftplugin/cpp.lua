vim.cmd([[
autocmd BufWinLeave *.cpp if &modifiable == 1 && &readonly == 0 | silent! exe "normal gg=GZZ" | endif

fun! SetMkfile()
	let filemk = "Makefile"
	let pathmk = "./"
	let depth = 1
	while depth < 4
		if filereadable(pathmk . filemk)
			return pathmk
		endif
		let depth += 1
		let pathmk = "../" . pathmk
	endwhile
	return "."
endf

command! -nargs=* Make tabnew | let $mkpath = SetMkfile() | make <args> -C $mkpath | c
]])
