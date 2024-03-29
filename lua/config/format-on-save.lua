local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")


format_on_save.setup({
	partial_update = true,
	exclude_path_patterns = {
		"/node_modules/",
		".local/share/nvim/lazy",
	},
	formatter_by_ft = {
		cpp = formatters.shell({ cmd = "clang-format", "%" }),
		c = formatters.shell({ cmd = "clang-format", "%" }),
		java = formatters.shell({ cmd = "clang-format", "%" }),
		python = formatters.black,
		javascript = formatters.prettierd,
		css = formatters.lsp,
		html = formatters.lsp,
		json = formatters.lsp,
		lua = formatters.lsp,
		markdown = formatters.prettierd,
		openscad = formatters.lsp,
		rust = formatters.shell({ cmd = "rustfmt", "%" }),
		scad = formatters.lsp,
		scss = formatters.lsp,
		sh = formatters.shfmt,
		terraform = formatters.lsp,
		typescript = formatters.prettierd,
		typescriptreact = formatters.prettierd,
		yaml = formatters.lsp,
		go = {
			formatters.shell({
				cmd = { "goimports-reviser", "-rm-unused", "-set-alias", "-format", "%" },
				tempfile = function()
					return vim.fn.expand("%") .. '.formatter-temp'
				end
			}),
			formatters.shell({ cmd = { "gofmt" } }),
		},

	},

	-- Optional: fallback formatter to use when no formatters match the current filetype
	fallback_formatter = {
		formatters.remove_trailing_whitespace,
		formatters.prettierd,
	},

	-- By default, all shell commands are prefixed with "sh -c" (see PR #3)
	-- To prevent that set `run_with_sh` to `false`.
	run_with_sh = false,
})
