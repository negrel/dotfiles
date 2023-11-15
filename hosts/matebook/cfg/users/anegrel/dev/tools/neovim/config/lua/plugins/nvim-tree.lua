require("nvim-tree").setup {
	view = {
		adaptive_size = true,
	},
	renderer = {
		icons = {
			git_placement = "signcolumn",
			modified_placement = "signcolumn",
		}
	},
	update_focused_file = {
		enable = true,
	}
}

-- KEYMAPS
local map = vim.keymap.set
local opts = { silent = true }
-- Toggle file explorer
map({ "n", "v", "c", "i" }, "<C-b>", "<Cmd>NvimTreeToggle<CR>", opts)
