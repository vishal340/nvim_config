local opts = { noremap=true, silent=true }
local keymap = vim.keymap.set

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
			["npm_doc"] = "https://docs.npmjs.com/searcch?q=%s",
		},
		["cpp"] ={
			["cppreference"] = "https://en.cppreference.com/mwiki/index.php?search=%s",
			["cplusplus"] = "https://cplusplus.com/search.do?q=%s",
		},
		["go"] ={
			["go.dev"] = "https://pkg.go.dev/search?q=%s",
		},
		["rust"] ={
			["library"] = "https://doc.rust-lang.org/std/index.html?search=%s",
			["Error_code"] = "https://doc.rust-lang.org/error_codes/%s.html"
		}
	},
})

keymap("n", "<leader>b","<cmd>lua require('browse').input_search()<cr>", opts)
keymap("n", "<localleader>b","<cmd>lua require('browse').browse(bookmarks)<cr>", opts)
keymap("n", "<localleader>bd","<cmd>lua require('browse.devdocs').search_with_filetype()<cr>", opts)
