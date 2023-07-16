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
keymap('i','<M-i>','<C-o>I',opts)
keymap('i','<M-a>','<End>',opts)
keymap('i','<M-c>','<C-o>.',opts)
keymap('i','<M-u>','<C-o>u',opts)
keymap('i','<M-o>','<Home>',opts)
keymap('i','<C-q>','<BS>',opts)
keymap('i','<C-w>','<Del>',opts)
keymap('i','<M-5>','<C-o>%',opts)


-- local null_ls = require("null-ls")

-- register any number of sources simultaneously
-- local null_sources = {
--     null_ls.builtins.formatting.prettier,
--     null_ls.builtins.diagnostics.write_good,
--     null_ls.builtins.code_actions.gitsigns,
-- }
-- null_ls.setup({ sources = null_sources })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  keymap('n', '<leader>gtD', '<cmd>tab split| lua vim.lsp.buf.declaration()<cr>', bufopts)
  keymap('n', '<leader>gtd', '<cmd>tab split| lua vim.lsp.buf.definition()<cr>', bufopts)
  keymap('n', '<leader>gti', '<cmd>tab split| lua vim.lsp.buf.implementation()<cr>', bufopts)
  keymap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', bufopts)
  keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', bufopts)
  keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', bufopts)
  keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', bufopts)
  keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', bufopts)
  keymap('n', '<leader>gtr', '<cmd>tab split| lua vim.lsp.buf.references()<cr>', bufopts)
  keymap('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<cr>', bufopts)

	keymap('n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
	keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
	keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
	keymap('n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<cr>', opts)
	keymap('n', '<leader>dh', '<cmd>lua vim.diagnostic.hide()<cr>', opts)
	keymap('n', '<leader>ds', '<cmd>lua vim.diagnostic.show()<cr>', opts)
	keymap('n', 'K', '<cmd>lua require("pretty_hover").hover()<cr>',opts)
	keymap('n', '<leader>k', '<cmd>lua require("pretty_hover").close()<cr>',opts)
end

local cmp = require'cmp'
local lspkind = require('lspkind')

require("cmp_git").setup()

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
	-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
	-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<TAB>'] = cmp.mapping.select_next_item(),
	['<S-TAB>'] = cmp.mapping.select_prev_item(),
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

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
	 capabilities = capabilities,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
	 capabilities = capabilities,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
	 capabilities = capabilities,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

require('lspconfig').clangd.setup{
    on_attach = on_attach,
	 capabilities = capabilities,
    flags = lsp_flags,
}

require('lspconfig')['jdtls'].setup{
    on_attach = on_attach,
	 capabilities = capabilities,
    flags = lsp_flags,
}
require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
	 capabilities = capabilities,
    flags = lsp_flags,
}

require('lspconfig')['asm_lsp'].setup{
    on_attach = on_attach,
	 capabilities = capabilities,
    flags = lsp_flags,
	 filetype = { "asm", "s", "S"},
	 command = "asm-lsp"
}

--telescope
keymap('n','<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
keymap('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
keymap('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
keymap('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

--hop(find characters in file)
keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>")
keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>")
keymap('n', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })<cr>")
keymap('n', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })<cr>")
keymap('i', '<M-f>', "<C-o><cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>")
keymap('i', '<M-F>', "<C-o><cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>")
keymap('i', '<M-t>', "<C-o><cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })<cr>")
keymap('i', '<M-T>', "<C-o><cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })<cr>")

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
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
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

--nvim-tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  open_on_tab = true,
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})

local node=require("nvim-tree.api").marks.list()
require("nvim-tree.api").marks.toggle(node)

keymap('n','<leader>e','<cmd>NvimTreeToggle<cr>',opts)
keymap('n','<leader>ef','<cmd>NvimTreeFocus<cr>',opts)

vim.keymap.set("n", "<leader>mn", require("nvim-tree.api").marks.navigate.next)
vim.keymap.set("n", "<leader>mp", require("nvim-tree.api").marks.navigate.prev)
vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select)

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})

--debug
local dap = require('dap')
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
			["npm_doc"] = "https://docs.npmjs.com/",
		},
		["cpp"] ={
			["cppreference"] = "https://duckduckgo.com/?sites=cppreference.com&q=%s&atb=v341-1&ia=web",
			["cplusplus"] = "https://cplusplus.com/search.do?q=%s",
		},
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
