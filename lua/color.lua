vim.api.nvim_set_hl(0, "FloatBorder", {bg="#000000", fg="#5E81AC"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg="#3B4252"})
vim.api.nvim_set_hl(0, "TabLine", {bg="#1C4F4B"})
vim.api.nvim_set_hl(0, "TabLineFill", {bg="#40008B"})
vim.api.nvim_set_hl(0, "Folded", {bg="#1C4F4B"})

vim.api.nvim_set_hl(0, 'CmpNormal', { bg='#000000', fg='#030178' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })

vim.diagnostic.config({
	virtual_text = false,
})
