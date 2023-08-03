local opts = { noremap=true, silent=true }
local keymap = vim.keymap.set

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  keymap('n', '<leader>gtD', '<cmd>tab split| lua vim.lsp.buf.declaration()<cr>', bufopts)
  keymap('n', '<leader>gvD', '<cmd>vs| lua vim.lsp.buf.declaration()<cr>', bufopts)
  keymap('n', '<leader>ghD', '<cmd>sp| lua vim.lsp.buf.declaration()<cr>', bufopts)
  keymap('n', '<leader>gtd', '<cmd>tab split| lua vim.lsp.buf.definition()<cr>', bufopts)
  keymap('n', '<leader>gvd', '<cmd>vs| lua vim.lsp.buf.definition()<cr>', bufopts)
  keymap('n', '<leader>ghd', '<cmd>sp| lua vim.lsp.buf.definition()<cr>', bufopts)
  keymap('n', '<leader>gti', '<cmd>tab split| lua vim.lsp.buf.implementation()<cr>', bufopts)
  keymap('n', '<leader>gvi', '<cmd>vs| lua vim.lsp.buf.implementation()<cr>', bufopts)
  keymap('n', '<leader>ghi', '<cmd>sp| lua vim.lsp.buf.implementation()<cr>', bufopts)
	keymap('n', '<leader>gi', function()
	  require("telescope.builtin").lsp_implementations()
		end, bufopts)
  keymap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', bufopts)
  keymap('n', '<leader>gd',function()
	  require('telescope.builtin').lsp_definitions()
  	end, bufopts)
  keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', bufopts)
  keymap('n', '<leader>gr', function()
	  require("telescope.builtin").lsp_references()
	  end, bufopts)
  keymap('n', '<leader>ll', function()
	  require("telescope.builtin").treesitter()
	  end, bufopts)
  keymap('n', '<leader>ic', function()
	  require("telescope.builtin").lsp_incoming_calls()
	  end, bufopts)
  keymap('n', '<leader>oc', function()
	  require("telescope.builtin").lsp_outgoing_calls()
	  end, bufopts)
  keymap('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<cr>', bufopts)

	keymap('n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
	keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
	keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
	keymap('n', '<leader>dl',function()
		require("telescope.builtin").diagnostics()
	end, opts)
	keymap('n', '<leader>dh', '<cmd>lua vim.diagnostic.hide()<cr>', opts)
	keymap('n', '<leader>ds', '<cmd>lua vim.diagnostic.show()<cr>', opts)
	keymap('n', 'K', '<cmd>lua require("pretty_hover").hover()<cr>',opts)
end

local lspconfig= require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lsp_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)
lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_defaults.on_attach = on_attach

lspconfig['pyright'].setup{}
lspconfig['tsserver'].setup{}
lspconfig.jsonls.setup{}
lspconfig['rust_analyzer'].setup{
        -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

lspconfig.clangd.setup{
    	 cmd = {
		 "clangd",
        "--header-insertion=never",
        "--query-driver=/usr/lib/llvm-14/bin/clang",
        "--all-scopes-completion",
        "--completion-style=detailed",
	 }
}

lspconfig['gopls'].setup{
    	 cmd = { 'jdtls' },
}

lspconfig['asm_lsp'].setup{
    	 filetype = { "asm", "s", "S"},
	 command = "asm-lsp"
}

lspconfig.lua_ls.setup({
    settings = {
    Lua = {
		 runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
		  checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})

lspconfig.vimls.setup{}
lspconfig.bashls.setup{}
lspconfig.eslint.setup{}
lspconfig.html.setup{}
lspconfig.cmake.setup{}
lspconfig.dockerls.setup{}
lspconfig.gradle_ls.setup{}
