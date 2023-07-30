local keymap = vim.keymap.set

local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local Job = require("plenary.job")

local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
  opts = opts or {}

  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require('telescope').setup{
  defaults = {
	buffer_previewer_maker = new_maker,
    mappings = {
      n = {
        ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
      },
      i = {
        ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
		  ["<C-u>"] = false,
		  ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
      },
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    multi_icon = "",
    sorting_strategy = "ascending",
    layout_strategy = nil,
    layout_config = nil,
    borderchars = {
      "─",
      "│",
      "─",
      "│",
      "┌",
      "┐",
      "┘",
      "└",
    },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
   },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
		"--glob",
		"!**/.git/*",
		"--trim",
    },
  },
  pickers = {
    buffers = {
      previewer = true,
      layout_config = {
        width = 0.7,
        prompt_position = "top",
      },
		find_files = {
      	mappings = {
        		n = {
         		["cd"] = function(prompt_bufnr)
	            local selection = require("telescope.actions.state").get_selected_entry()
   	         local dir = vim.fn.fnamemodify(selection.path, ":p:h")
      	      require("telescope.actions").close(prompt_bufnr)
         	   -- Depending on what you want put `cd`, `lcd`, `tcd`
            	vim.cmd(string.format("silent lcd %s", dir))
          	end
        		}
      	}
    	},
    },
    builtin = {
      previewer = true,
      layout_config = {
        width = 0.7,
        prompt_position = "top",
      },
    },
    find_files = {
      previewer = true,
      layout_config = {
        width = 0.7,
        prompt_position = "top",
      },
    },
    help_tags = {
      layout_config = {
        prompt_position = "top",
        scroll_speed = 4,
        height = 0.9,
        width = 0.9,
        preview_width = 0.55,
      },
    },
    live_grep = {
      layout_strategy = "vertical",
      layout_config = {
        width = 0.9,
        height = 0.9,
        preview_cutoff = 1,
        mirror = false,
      },
    },
    lsp_implementations = {
      layout_strategy = "vertical",
      layout_config = {
        width = 0.9,
        height = 0.9,
        preview_cutoff = 1,
        mirror = false,
      },
    },
    lsp_references = {
      layout_strategy = "vertical",
      layout_config = {
        width = 0.9,
        height = 0.9,
        preview_cutoff = 1,
        mirror = false,
      },
    },
    oldfiles = {
      previewer = true,
      layout_config = {
        width = 0.9,
        prompt_position = "top",
      },
    },
  },
}

require('telescope').load_extension('fzf')

require("telescope.pickers.layout_strategies").buffer_window = function(self)
  local layout = require("telescope.pickers.window").get_initial_window_options(self)
  local prompt = layout.prompt
  local results = layout.results
  local preview = layout.preview
  local config = self.layout_config
  local padding = self.window.border and 2 or 0
  local width = vim.api.nvim_win_get_width(self.original_win_id)
  local height = vim.api.nvim_win_get_height(self.original_win_id)
  local pos = vim.api.nvim_win_get_position(self.original_win_id)
  local wline = pos[1] + 1
  local wcol = pos[2] + 1
  
  -- Height
  prompt.height = 1
  preview.height = self.previewer and math.floor(height * 0.4) or 0
  results.height = height
    - padding
    - (prompt.height + padding)
    - (self.previewer and (preview.height + padding) or 0)
  
  -- Line
  local rows = {}
  local mirror = config.mirror == true
  local top_prompt = config.prompt_position == "top"
  if mirror and top_prompt then
    rows = { prompt, results, preview }
  elseif mirror and not top_prompt then
    rows = { results, prompt, preview }
  elseif not mirror and top_prompt then
    rows = { preview, prompt, results }
  elseif not mirror and not top_prompt then
    rows = { preview, results, prompt }
  end
  local next_line = 1 + padding / 2
  for k, v in pairs(rows) do
    if v.height ~= 0 then
      v.line = next_line
      next_line = v.line + padding + v.height
    end
  end
  
  -- Width
  prompt.width = width - padding
  results.width = prompt.width
  preview.width = prompt.width
  
  -- Col
  prompt.col = wcol + padding / 2
  results.col = prompt.col
  preview.col = prompt.col
  
  if not self.previewer then
    layout.preview = nil
  end
  
  return layout
end

local find_files_from_project_git_root = function()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
  end
  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end
  local opts = {}
  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end
  require("telescope.builtin").find_files(opts)
end

local live_grep_from_project_git_root = function()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")

		return vim.v.shell_error == 0
	end

	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end

	local opts = {}

	if is_git_repo() then
		opts = {
			cwd = get_git_root(),
		}
	end

	require("telescope.builtin").live_grep(opts)
end

keymap('n', '<leader>ff',function()
		find_files_from_project_git_root()
	end)
keymap('n', '<leader>fg', function()
		live_grep_from_project_git_root()
	end)
keymap('n', '<leader>fm', ':Telescope marks preview=true<cr>')
keymap('n', '<leader>fb', ':Telescope buffers<cr>')
keymap('n', '<leader>fh', ':Telescope help_tags preview=true<cr>')
keymap('n', '<leader>fo', ':Telescope oldfiles preview=false<cr>')
keymap('n', '<localleader>gc', function()
	require('telescope.builtin').git_bcommits()
end)
keymap('v', '<localleader>gc', function()
	require('telescope.builtin').git_bcommits_range()
end)
keymap('n', '<localleader>gb', function()
	require('telescope.builtin').git_branches()
end)
keymap('n', '<localleader>gs', function()
	require('telescope.builtin').git_status()
end)
