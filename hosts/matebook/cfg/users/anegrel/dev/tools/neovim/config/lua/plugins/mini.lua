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
require("mini.pairs").setup {}
require("mini.trailspace").setup {}
require("mini.comment").setup {}
