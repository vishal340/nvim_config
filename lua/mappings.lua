local opts = { noremap=true, silent=true }
local keymap = vim.keymap.set

vim.keymap.set('n',"<leader>bt",":highlight Normal guibg=NONE<cr>")
vim.keymap.set('n',"<leader>bb",":highlight Normal guibg=BLACK<cr>")
vim.keymap.set('c', "<M-h>", "vert h ")

keymap('i','<M-h>','<Left>',opts)
keymap('i','<M-j>','<Down>',opts)
keymap('i','<M-k>','<Up>',opts)
keymap('i','<M-l>','<Right>',opts)
keymap('i','<M-w>','<C-o>w',opts)
keymap('i','<M-W>','<C-o>W',opts)
keymap('i','<M-b>','<C-o>b',opts)
keymap('i','<M-B>','<C-o>B',opts)
keymap('i','<M-e>','<C-o>e',opts)
keymap('i','<M-E>','<C-o>E',opts)
keymap('i','<M-i>','<C-o>^',opts)
keymap('i','<M-a>','<C-o>$',opts)
keymap('i','<M-.>','<C-o>.',opts)
keymap('i','<M-u>','<C-o>u',opts)
keymap('i','<M-5>','<C-o>%',opts)
keymap('i','<M-d>','<C-o>d',opts)
keymap('i','<M-y>','<C-o>y',opts)

require("mason").setup()
require("mason-lspconfig").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({paths = {"~/.config/nvim/snippets"}})
require'sniprun'.setup({selected_interpreters = {'Python3_jupyter'}})

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

--hop(find characters in file)
vim.keymap.set('', 'f', ':HopChar1<cr>',{remap=true})
vim.keymap.set('', 'F', ':HopWord<cr>',{remap=true})
vim.keymap.set('i', '<M-f>', '<C-o>:HopChar1<cr>')
vim.keymap.set('i', '<M-F>', '<C-o>:HopWord<cr>')

vim.cmd('source $HOME/.config/nvim/lua/config/telescope.lua')
vim.cmd('source $HOME/.config/nvim/lua/config/lspconfig.lua')
vim.cmd('source $HOME/.config/nvim/lua/config/nvim_tree.lua')
vim.cmd('source $HOME/.config/nvim/lua/config/dap.lua')
vim.cmd('source $HOME/.config/nvim/lua/config/lualine.lua')
vim.cmd('source $HOME/.config/nvim/lua/config/sshfs.lua')
vim.cmd('source $HOME/.config/nvim/lua/config/fzf.vim')
vim.cmd('source $HOME/.config/nvim/lua/config/cmp.lua')

require("gist").setup({
	  private = false, -- All gists will be private, you won't be prompted again
	  clipboard = "+", -- The registry to use for copying the Gist URL
	  list = {
			-- If there are multiple files in a gist you can scroll them,
			-- with vim-like bindings n/p next previous
		mappings = {
			 next_file = "<TAB>",
			 prev_file = "<S-TAB>"
		}
	  }
 })

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = {'org', 'rust', 'toml'}, -- Or run :TSUpdate org
}

require('orgmode').setup({})

require('Comment').setup()

--sniprun
--------------------------
keymap("n","<leader>r",":SnipRun<cr>",opts)
keymap("v","<leader>r",":'<,'>SnipRun<cr>",opts)
vim.g.markdown_fenced_languages = { "cpp", "c","rust", "go","lua", "bash", "javascript", "typescript", "python" }

--which-key
-------------------------
require("which-key").register({prefix = {"leader", "localleader"}})

--nvim-spectre
------------------------
require('spectre').setup()

vim.keymap.set('n', '<localleader>st', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('v', '<leader>sv', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})

--highstr
-----------------
vim.api.nvim_set_keymap("v","<localleader>hc",":<c-u>HSHighlight<CR>",opts)
vim.api.nvim_set_keymap("v","<localleader>hr",":<c-u>HSRmHighlight<CR>",opts)
