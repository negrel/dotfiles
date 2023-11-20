require("mini.move").setup {
	mappings = {
		line_left = "",
		line_right = "",
		line_down = "",
		line_up = ""
	}
}

require("mini.jump2d").setup {
	allowed_lines = {
		blank = false,
	},
	allowed_windows = {
		current = true,
		not_current = false
	}
}
require("mini.jump").setup {}
require("mini.pairs").setup {}
require("mini.trailspace").setup {}
require("mini.comment").setup {}
require("mini.surround").setup {}
require("mini.indentscope").setup {}
require("mini.cursorword").setup {}

local minifiles = require("mini.files")
minifiles.setup {}

-- KEYMAPS
local map = vim.keymap.set
local opts = { silent = true }
-- Toggle file explorer
map({ "n", "v", "c", "i" }, "<C-b>", function()
	local bufname = vim.api.nvim_buf_get_name(0)
	local isTerm = bufname:find("term", 1, true) == 1
	if isTerm then
		minifiles.open(nil, false)
	else
		minifiles.open(bufname)
	end
end, opts)

-- Random colorscheme.
local MiniHues = require("mini.hues")
local randomhue = MiniHues.gen_random_base_colors()
MiniHues.setup(randomhue)
local palette           = MiniHues.make_palette(randomhue)
vim.g.terminal_color_8  = palette.bg_mid2
vim.g.terminal_color_9  = palette.red_mid2
vim.g.terminal_color_10 = palette.green_mid2
vim.g.terminal_color_11 = palette.yellow_mid2
vim.g.terminal_color_12 = palette.azure_mid2
vim.g.terminal_color_13 = palette.purple_mid2
vim.g.terminal_color_14 = palette.cyan_mid2
vim.g.terminal_color_15 = palette.fg_mid2
