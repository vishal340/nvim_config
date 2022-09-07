require('plugins')

vim.cmd('source $HOME/.config/nvim/old_mappings.vim')

require("mason").setup()
require("mason-lspconfig").setup()
require("luasnip.loaders.from_vscode").lazy_load()

require('mappings')
require('options')

vim.keymap.set('n',"<leader>bt",":highlight Normal guibg=NONE<cr>")
vim.keymap.set('n',"<leader>bb",":highlight Normal guibg=BLACK<cr>")
