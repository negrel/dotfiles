local nvim_tree_events = require("nvim-tree.events")
local bufferline_api = require("bufferline.api")

-- adapt tabs bar to nvim tree file explorer
local function get_tree_size()
	return require("nvim-tree.view").View.width
end

nvim_tree_events.subscribe("TreeOpen", function()
	bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe("Resize", function()
	bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe("TreeClose", function()
	bufferline_api.set_offset(0)
end)

require("bufferline").setup {
	icons = {
		button = '',
		modified = {
			button = ''
		}
	}
}

-- KEYMAPS
local map = vim.keymap.set
local opts = { silent = true }

-- Close tabs
map({ "n", "v", "c", "i" }, "<A-q>", "<Cmd>BufferClose<CR>", opts)

-- Move tabs
map("n", "<A-S-a>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A-S-e>", "<Cmd>BufferMoveNext<CR>", opts)

-- Navigate tabs
map("n", "<A-a>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-e>", "<Cmd>BufferNext<CR>", opts)

map({ "n", "i" }, "<A-&>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "é", "<Cmd>BufferGoto 2<CR>", opts)
map({ "n", "i" }, "<A-\">", "<Cmd>BufferGoto 3<CR>", opts)
map({ "n", "i" }, "<A-'>", "<Cmd>BufferGoto 4<CR>", opts)
map({ "n", "i" }, "<A-(>", "<Cmd>BufferGoto 5<CR>", opts)
map({ "n", "i" }, "<A-->", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "è", "<Cmd>BufferGoto 7<CR>", opts)
map({ "n", "i" }, "<A-_>", "<Cmd>BufferGoto 8<CR>", opts)
map({ "n", "i" }, "<A-ç>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "à", "<Cmd>BufferLast<CR>", opts)
