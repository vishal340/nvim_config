local on_attach = function(bufnr)

	local api = require "nvim-tree.api"
	local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set('n', 'u', api.tree.change_root_to_parent,opts('Up'))
	-- vim.keymap.set('n', '<leader>v', api.node.open.vertical,opts('Open: Vertical Split'))
	-- vim.keymap.set('n', '<leader>h', api.node.open.horizontal,opts('Open: horizontal Split'))
end
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  open_on_tab = true,
  view = {
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  on_attach = on_attach,
})

vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})
