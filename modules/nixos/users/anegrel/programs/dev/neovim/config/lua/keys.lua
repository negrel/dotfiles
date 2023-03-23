local win = require("lib.win")
local map = vim.keymap.set
local merge = function(...)
	return vim.tbl_extend("force", ...)
end

local opts = { silent = true }

local function scroll_by(offset)
	return function()
		win.cursor.scroll_by(nil, offset)
	end
end

local scroll_by_page_up = function()
	win.scroll_by_page(nil, -1)
end

-- NAVIGATION
-- scrolling
map({ "n", "v", "i" }, "<C-f>", scroll_by(4), opts)
map({ "n", "v", "i" }, "<C-d>", scroll_by( -4), opts)
map({ "n", "v", "c", "i" }, "<PageDown>", win.scroll_by_page, opts)
map({ "n", "v", "c", "i" }, "<PageUp>", scroll_by_page_up, opts)

-- cursor
map({ "v", "c", "i" }, "<A-h>", "<Left>", opts)
map({ "v", "c", "i" }, "<A-j>", "<Down>", opts)
map({ "v", "c", "i" }, "<A-k>", "<Up>", opts)
map({ "v", "c", "i" }, "<A-l>", "<Right>", opts)

-- cursor word
map({ "v", "c", "i" }, "<A-a>", "<C-Left>", opts)
map({ "v", "c", "i" }, "<A-e>", "<C-Right>", opts)

-- cursor line
map({ "n", "v", "c", "i" }, "<C-a>", "<Home>", opts)
map({ "n", "v", "c", "i" }, "<C-e>", "<End>", opts)

-- MODE
map("t", "<Esc>", "<C-\\><C-n>", opts) -- exit terminal mode with escape
map({ "n", "v", "c", "i", "t" }, "<A-c>", "<Esc>", merge(opts, { remap = true })) -- exit terminal mode with escape

-- WINDOWS
map("n", "<A-h>", "<C-w>h", opts) -- focus left window
map("n", "<A-j>", "<C-w>j", opts) -- focus left window
map("n", "<A-k>", "<C-w>k", opts) -- focus left window
map("n", "<A-l>", "<C-w>l", opts) -- focus left window

-- BUFFERS
map("c", "w!!<CR>", "w ! sudo tee % > /dev/null<CR>", opts) -- write as sudo
map({ "n", "v", "c", "i" }, "<C-s>", "<Cmd>w<CR>", opts) -- write shortcut

-- DIAGNOSTICS
map("n", "ds", vim.diagnostic.open_float, opts) -- open diagnostic window
map("n", "dn", vim.diagnostic.goto_next, opts) -- goto next diagnostic
map("n", "dp", vim.diagnostic.goto_prev, opts) -- goto prev diagnostic
