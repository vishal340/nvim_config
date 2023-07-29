local keymap = vim.keymap.set

require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
      },
      i = {
        ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
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
    },
  },
  pickers = {
    buffers = {
      previewer = true,
      layout_config = {
        width = 0.7,
        prompt_position = "top",
      },
    },
    builtin = {
      previewer = true,
      layout_config = {
        width = 0.3,
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

require("telescope.pickers.layout_strategies").buffer_window = function(self)
  local layout = require("telescope.pickers.window").get_initial_window_options(self)
  local prompt = layout.prompt
  local results = layout.results
  local preview = layout.preview
  local config = self.layout_config
  local padding = self.window.border and 2 or 0
  local width = api.nvim_win_get_width(self.original_win_id)
  local height = api.nvim_win_get_height(self.original_win_id)
  local pos = api.nvim_win_get_position(self.original_win_id)
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

keymap('n', '<leader>ff', ':Telescope find_files no_ignore=false<cr>')
keymap('n', '<leader>fg', ':Telescope live_grep preview=true<cr>')
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
