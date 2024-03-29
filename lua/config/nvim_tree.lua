local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

local function my_on_attach(bufnr)
	local api = require('nvim-tree.api')
	local function opt(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opt('CD'))
	vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opt('Open: In Place'))
	vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opt('Info'))
	vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opt('Rename: Omit Filename'))
	vim.keymap.set('n', 't', api.node.open.tab, opt('Open: New Tab'))
	vim.keymap.set('n', 'v', api.node.open.vertical, opt('Open: Vertical Split'))
	vim.keymap.set('n', 'h', api.node.open.horizontal, opt('Open: Horizontal Split'))
	vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opt('Close Directory'))
	vim.keymap.set('n', '<CR>', api.node.open.edit, opt('Open'))
	vim.keymap.set('n', '<Tab>', api.node.open.preview, opt('Open Preview'))
	vim.keymap.set('n', '>', api.node.navigate.sibling.next, opt('Next Sibling'))
	vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opt('Previous Sibling'))
	vim.keymap.set('n', '.', api.node.run.cmd, opt('Run Command'))
	vim.keymap.set('n', '-', api.tree.change_root_to_parent, opt('Up'))
	vim.keymap.set('n', 'a', api.fs.create, opt('Create'))
	vim.keymap.set('n', 'bmv', api.marks.bulk.move, opt('Move Bookmarked'))
	vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opt('Toggle No Buffer'))
	vim.keymap.set('n', 'c', api.fs.copy.node, opt('Copy'))
	vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opt('Toggle Git Clean'))
	vim.keymap.set('n', '[c', api.node.navigate.git.prev, opt('Prev Git'))
	vim.keymap.set('n', ']c', api.node.navigate.git.next, opt('Next Git'))
	vim.keymap.set('n', 'd', api.fs.remove, opt('Delete'))
	vim.keymap.set('n', 'D', api.fs.trash, opt('Trash'))
	vim.keymap.set('n', 'E', api.tree.expand_all, opt('Expand All'))
	vim.keymap.set('n', 'e', api.fs.rename_basename, opt('Rename: Basename'))
	vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opt('Next Diagnostic'))
	vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opt('Prev Diagnostic'))
	vim.keymap.set('n', 'F', api.live_filter.clear, opt('Clean Filter'))
	vim.keymap.set('n', 'f', api.live_filter.start, opt('Filter'))
	vim.keymap.set('n', 'g?', api.tree.toggle_help, opt('Help'))
	vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opt('Copy Absolute Path'))
	vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opt('Toggle Dotfiles'))
	vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opt('Toggle Git Ignore'))
	vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opt('Last Sibling'))
	vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opt('First Sibling'))
	vim.keymap.set('n', 'm', api.marks.toggle, opt('Toggle Bookmark'))
	vim.keymap.set('n', 'o', api.node.open.edit, opt('Open'))
	vim.keymap.set('n', 'O', api.node.open.no_window_picker, opt('Open: No Window Picker'))
	vim.keymap.set('n', 'p', api.fs.paste, opt('Paste'))
	vim.keymap.set('n', 'P', api.node.navigate.parent, opt('Parent Directory'))
	vim.keymap.set('n', 'q', api.tree.close, opt('Close'))
	vim.keymap.set('n', 'r', api.fs.rename, opt('Rename'))
	vim.keymap.set('n', 'R', api.tree.reload, opt('Refresh'))
	vim.keymap.set('n', 's', api.node.run.system, opt('Run System'))
	vim.keymap.set('n', 'S', api.tree.search_node, opt('Search'))
	vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opt('Toggle Hidden'))
	vim.keymap.set('n', 'W', api.tree.collapse_all, opt('Collapse'))
	vim.keymap.set('n', 'x', api.fs.cut, opt('Cut'))
	vim.keymap.set('n', 'y', api.fs.copy.filename, opt('Copy Name'))
	vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opt('Copy Relative Path'))
	vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opt('Open'))
	vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opt('CD'))
end
require("nvim-tree").setup({
	on_attach = my_on_attach,
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
})

local function tab_win_closed(winnr)
	local api = require "nvim-tree.api"
	local tabnr = vim.api.nvim_win_get_tabpage(winnr)
	local bufnr = vim.api.nvim_win_get_buf(winnr)
	local buf_info = vim.fn.getbufinfo(bufnr)[1]
	local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
	local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
	if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
		-- Close all nvim tree on :q
		if not vim.tbl_isempty(tab_bufs) then     -- and was not the last window (not closed automatically by code below)
			api.tree.close()
		end
	else                                                -- else closed buffer was normal buffer
		if #tab_bufs == 1 then                           -- if there is only 1 buffer left in the tab
			local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
			if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
				vim.schedule(function()
					if #vim.api.nvim_list_wins() == 1 then  -- if its the last buffer in vim
						vim.cmd "quit"                       -- then close all of vim
					else                                    -- else there are more tabs open
						vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
					end
				end)
			end
		end
	end
end

vim.api.nvim_create_autocmd("WinClosed", {
	callback = function()
		local winnr = tonumber(vim.fn.expand("<amatch>"))
		vim.schedule_wrap(tab_win_closed(winnr))
	end,
	nested = true
})

keymap('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', opts)
keymap('n', '<leader>ef', '<cmd>NvimTreeFocus<cr>', opts)
