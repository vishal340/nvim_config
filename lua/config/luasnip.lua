local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })

vim.keymap.set({ "i" }, "<M-j>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<M-l>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<M-h>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-x>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })
