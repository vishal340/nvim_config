require('plugins')
require('options')
vim.cmd('source $HOME/.config/nvim/old_mappings.vim')
require('color')
require('mappings')
require('scripts')


vim.cmd("highlight Normal guibg=NONE<cr>")
