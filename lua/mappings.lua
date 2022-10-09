local opts = { noremap=true, silent=true }
local keymap = vim.keymap.set

require('lspsaga').init_lsp_saga()

keymap('n', '<leader>df', vim.diagnostic.open_float, opts)
keymap('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
keymap('n', '<leader>dn', vim.diagnostic.goto_next, opts)
keymap('n', '<leader>dl', vim.diagnostic.setloclist, opts)

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
  keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  keymap('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  keymap('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  keymap('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  keymap('n', 'gr', '<cmd>tab split| lua vim.lsp.buf.references()<cr>', bufopts)
  keymap('n', '<leader>bf', vim.lsp.buf.formatting, bufopts)

  --TODO add more features from lspsaga
  keymap("n", "<leader>lf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
  keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
  keymap("v", "<leader>rca", "<cmd>Lspsaga range_code_action<CR>", { silent = true })
  keymap("n", "<leader>pd", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
  keymap("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
  keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
  keymap("n", "<leader>hd", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
end

local cmp = require'cmp'
local lspkind = require('lspkind')

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
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
		{name = 'path'}
    }),
	formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

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
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

require('lspconfig')['clangd'].setup{
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

--telescope
keymap('n','<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
keymap('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
keymap('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
keymap('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

--hop(find characters in file)
vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>", {})
vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>", {})
vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })<cr>", {})
vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })<cr>", {})

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

local node=require("nvim-tree.api").marks.list()
require("nvim-tree.api").marks.toggle(node)

keymap('n','<leader>e','<cmd>NvimTreeToggle<cr>',opts)
keymap('n','<leader>ef','<cmd>NvimTreeFocus<cr>',opts)

vim.keymap.set("n", "<leader>mn", require("nvim-tree.api").marks.navigate.next)
vim.keymap.set("n", "<leader>mp", require("nvim-tree.api").marks.navigate.prev)
vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select)

--window-picker

vim.api.nvim_set_keymap('n', '<leader>ww', "WindowPick",opts)
vim.api.nvim_set_keymap('n', '<leader>ws', "WindowSwap",opts)
vim.api.nvim_set_keymap('n', '<leader>wq', "WindowZap",opts)

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

require("dapui").setup()
require('Comment').setup()
