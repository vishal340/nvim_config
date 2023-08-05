vim.api.nvim_set_hl(0, "FloatBorder", {bg="#000000", fg="#5E81AC"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg="#3B4252"})
vim.api.nvim_set_hl(0, "TabLine", {bg="#1C4F4B", fg="#A7C824"})
vim.api.nvim_set_hl(0, "TabLineFill", {bg="#40008B"})
vim.api.nvim_set_hl(0, "TabLineSel", {fg="#b72eb4"})
vim.api.nvim_set_hl(0, "Folded", {bg="#1C4F4B"})

vim.api.nvim_set_hl(0, 'CmpNormal', { bg='#000000', fg='#030178' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })

vim.api.nvim_set_hl(0, "LineNrAbove", {fg="#a50000"})
vim.api.nvim_set_hl(0, "LineNrBelow", {fg="#009e00"})
vim.api.nvim_set_hl(0, "Normal", {fg="#3db7b7"})
-- vim.api.nvim_set_hl(0, "lCursor", {bg="#b75a79"})
vim.api.nvim_set_hl(0, "Visual", {fg="#613c45"})

vim.diagnostic.config({
	virtual_text = false,
})
