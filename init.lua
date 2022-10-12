require('plugins')

vim.cmd('source $HOME/.config/nvim/old_mappings.vim')

require("mason").setup()
require("mason-lspconfig").setup()
require('lualine').setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({paths = {"./~/.config/nvim/snippets"}})

require('mappings')
require('options')

vim.cmd("highlight Normal guibg=NONE<cr>")
vim.keymap.set('n',"<leader>bt",":highlight Normal guibg=NONE<cr>")
vim.keymap.set('n',"<leader>bb",":highlight Normal guibg=BLACK<cr>")

require'nvim-treesitter.configs'.setup{highlight={enable=true}}
