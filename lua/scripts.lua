vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() =~ glob2regpat('term:*/bin/bash') | quit | endif",
    nested = true,
})
