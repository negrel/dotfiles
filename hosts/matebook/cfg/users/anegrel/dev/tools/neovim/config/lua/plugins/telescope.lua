local actions = require("telescope.actions")
require("telescope").setup {
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<A-j>"] = actions.move_selection_next,
				["<A-k>"] = actions.move_selection_previous,
				["<A-f>"] = actions.preview_scrolling_down,
				["<A-d>"] = actions.preview_scrolling_up
			},
		},
	}
}

local win = require("lib.win")
local builtin = require("telescope.builtin")
local telescope = function(cmd, args)
	args = args or {}
	args.width = args.width or 0.75
	args.height = args.height or 0.85
	cmd = builtin[cmd]

	return function()
		if win.is_vertical(nil, 2.55) then
			args.layout_strategy = "vertical"
		else
			args.layout_strategy = "horizontal"
		end
		cmd(args)
	end
end

-- KEYMAPS
local map = vim.keymap.set
local opts = { silent = true }

map("n", "<Leader>ff", telescope("find_files"), opts)
map("n", "<Leader>gg", telescope("live_grep"), opts)
map("n", "<Leader>hc", telescope("command_history"), opts)
map("n", "<Leader>hs", telescope("search_history"), opts)
map("n", "<Leader>hh", telescope("help_tags"), opts)
map("n", "<Leader>hk", telescope("keymaps"), opts)
map("n", "<Leader>fb", telescope("buffers"), opts)
