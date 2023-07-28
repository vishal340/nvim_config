local opts = { noremap=true, silent=true }
local keymap = vim.keymap.set

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

vim.cmd('source $HOME/.config/nvim/lua/config/telescope.lua')
vim.cmd('source $HOME/.config/nvim/lua/config/lspconfig.lua')
vim.cmd('source $HOME/.config/nvim/lua/config/nvim_tree.lua')

local cmp = require'cmp'
local lspkind = require('lspkind')

require("cmp_git").setup()

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

cmp.setup({
 snippet = {
	-- REQUIRED - you must specify a snippet engine
	expand = function(args)
	require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	end,
 },
 window = {
	-- completion = cmp.config.window.bordered(),
	-- documentation = cmp.config.window.bordered(),
 },
 mapping = cmp.mapping.preset.insert({
	['<TAB>'] = cmp.mapping.select_next_item(),
	['<S-TAB>'] = cmp.mapping.select_prev_item(),
	['<C-b>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<M-e>'] = cmp.mapping.abort(),
	['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
 }),
 sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	{ name = 'luasnip' }, -- For luasnip users.
 }, {
	{ name = 'buffer' },
	{name = 'path'},
	{name = 'orgmode'},
 }),
formatting = {
 format = lspkind.cmp_format({
	mode = 'symbol', -- show only symbol annotations
	maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

 })
}
})

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })


--hop(find characters in file)
local hop=require('hop')
local directions=require('hop.hint').HintDirection
vim.keymap.set('n', 'f', "<cmd>lua hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })<cr>")
vim.keymap.set('n', 'F', "<cmd>lua hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })<cr>")
vim.keymap.set('n', 't', "<cmd>lua hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })<cr>")
vim.keymap.set('n', 'T', "<cmd>lua hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })<cr>")
keymap('i', '<M-f>', "<C-o><cmd>lua hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })<cr>")
keymap('i', '<M-F>', "<C-o><cmd>lua hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })<cr>")
keymap('i', '<M-t>', "<C-o><cmd>lua hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })<cr>")
keymap('i', '<M-T>', "<C-o><cmd>lua hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })<cr>")

-- keymap('i','<M-f>','<C-o>f',opts)
-- keymap('i','<M-F>','<C-o>F',opts)
-- keymap('i','<M-t>','<C-o>t',opts)
-- keymap('i','<M-T>','<C-o>T',opts)
keymap('n','<localleader>f','f',opts)
keymap('n','<localleader>F','F',opts)
keymap('n','<localleader>t','t',opts)
keymap('n','<localleader>T','T',opts)

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

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_x = {'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

keymap('n','<leader>e','<cmd>NvimTreeToggle<cr>',opts)
keymap('n','<leader>ef','<cmd>NvimTreeFocus<cr>',opts)

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = {'org', 'rust', 'toml'}, -- Or run :TSUpdate org
}

require('orgmode').setup({})

--debug
local dap = require('dap')
require("dapui").setup()
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode-14', -- adjust as needed
    name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
	 args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

keymap('n', '<localleader>dc', function() require('dap').continue() end ,opts)
keymap('n', '<localleader>dsv', function() require('dap').step_over() end ,opts)
keymap('n', '<localleader>dsi', function() require('dap').step_into() end ,opts)
keymap('n', '<localleader>dso', function() require('dap').step_out() end ,opts)
keymap('n', '<localleader>db', function() require('dap').toggle_breakpoint() end ,opts)
keymap('n', '<localleader>dr', function() require('dap').repl.open() end ,opts)
keymap('n', '<localleader>dl', function() require('dap').run_last() end ,opts)
keymap({'n', 'v'}, '<localleader>dh', function()
	require('dap.ui.widgets').hover()
 end ,opts)
keymap({'n', 'v'}, '<localleader>dp', function()
	require('dap.ui.widgets').preview()
 end ,opts)
keymap('n', '<localleader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
 end ,opts)
keymap('n', '<localleader>dfs', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
 end ,opts)

keymap('n', '<localleader>dt',':lua require("dapui").toggle()<cr>', opts)
keymap('v', '<localleader>de', ':lua require("dapui").eval()<cr>', opts)

require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

require('Comment').setup()

-- --browser-search
-- -----------------
require('browse').setup({
	provider = "duckduckgo",
	bookmarks = {
		"https://devdocs.io/%s",
		["github"] = {
			["code_search"] = "https://github.com/search?q=%s&type=code",
			["repo_search"] = "https://github.com/search?q=%s&type=repositories",
			["issues_search"] = "https://github.com/search?q=%s&type=issues",
			["pulls_search"] = "https://github.com/search?q=%s&type=pullrequests",
  		},
		["node"] ={
			["npm_doc"] = "https://docs.npmjs.com/searcch?q=%s",
		},
		["cpp"] ={
			["cppreference"] = "https://en.cppreference.com/mwiki/index.php?search=%s",
			["cplusplus"] = "https://cplusplus.com/search.do?q=%s",
		},
		["go"] ={
			["go.dev"] = "https://pkg.go.dev/search?q=%s",
		},
		["rust"] ={
			["library"] = "https://doc.rust-lang.org/std/index.html?search=%s",
			["Error_code"] = "https://doc.rust-lang.org/error_codes/%s.html"
		}
	},
})

keymap("n", "<leader>b","<cmd>lua require('browse').input_search()<cr>", opts)
keymap("n", "<localleader>b","<cmd>lua require('browse').browse(bookmarks)<cr>", opts)
keymap("n", "<localleader>bd","<cmd>lua require('browse.devdocs').search_with_filetype()<cr>", opts)

--sniprun
--------------------------
keymap("n","<leader>r",":SnipRun<cr>",opts)
keymap("v","<leader>r",":'<,'>SnipRun<cr>",opts)
vim.g.markdown_fenced_languages = { "cpp", "c","rust", "go","lua", "bash", "javascript", "typescript" }

--which-key
-------------------------
require("which-key").register({prefix = {"leader", "localleader"}})

--quicknote
-------------------------
keymap("n","<localleader>qn", ":lua require('quicknote').NewNoteAtCurrentLine()<cr>",opts)
keymap("n","<localleader>qs", ":lua require('quicknote').ShowNoteSigns()<cr>",opts)
keymap("n","<localleader>qe", "require('quicknote').OpenNoteAtCurrentLine()<cr>",opts)

--nvim-spectre
------------------------
require('spectre').setup()

vim.keymap.set('n', '<localleader>st', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('v', '<leader>sv', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
