require('remote-sshfs').setup({})
require('telescope').load_extension 'remote-sshfs'

local api = require('remote-sshfs.api')
vim.keymap.set('n', '<localleader>rc', api.connect, {})
vim.keymap.set('n', '<localleader>rd', api.disconnect, {})
vim.keymap.set('n', '<localleader>re', api.edit, {})

-- (optional) Override telescope find_files and live_grep to make dynamic based on if connected to host
local builtin = require("telescope.builtin")
local connections = require("remote-sshfs.connections")
vim.keymap.set("n", "<localleader>ff", function()
	if connections.is_connected then
		api.find_files()
	else
		builtin.find_files()
	end
end, {})
vim.keymap.set("n", "<localleader>fg", function()
	if connections.is_connected then
		api.live_grep()
	else
		builtin.live_grep()
	end
end, {})
