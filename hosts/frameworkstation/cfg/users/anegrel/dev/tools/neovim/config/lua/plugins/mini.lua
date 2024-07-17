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
