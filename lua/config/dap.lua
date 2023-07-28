local opts = { noremap=true, silent=true }
local keymap = vim.keymap.set

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
