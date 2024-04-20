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
map({ "n", "v", "i" }, "<C-d>", scroll_by(-4), opts)
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
map("t", "<Esc>", "<C-\\><C-n>", opts)                                            -- exit terminal mode with escape
map({ "n", "v", "c", "i", "t" }, "<A-c>", "<Esc>", merge(opts, { remap = true })) -- exit terminal mode with escape

-- WINDOWS
map("n", "<A-h>", "<C-w>h", opts) -- focus left window
map("n", "<A-j>", "<C-w>j", opts) -- focus left window
map("n", "<A-k>", "<C-w>k", opts) -- focus left window
map("n", "<A-l>", "<C-w>l", opts) -- focus left window

-- TABS
map("n", "<A-e>", "<Cmd>tabnext<CR>", opts)
map("n", "<A-E>", "<Cmd>+tabmove<CR>", opts)
map("n", "<A-a>", "<Cmd>tabprevious<CR>", opts)
map("n", "<A-A>", "<Cmd>-tabmove<CR>", opts)
map("n", "<A-q>", "<Cmd>tabclose<CR>", opts)
map("n", "<A-t>", "<Cmd>tab split<CR>", opts)
map("n", "<A-&>", "<Cmd>1tabnext<CR>", opts)
map("n", "é", "<Cmd>2tabnext<CR>", opts)
map("n", "<A-\">", "<Cmd>3tabnext<CR>", opts)
map("n", "<A-'>", "<Cmd>4tabnext<CR>", opts)
map("n", "<A-(>", "<Cmd>5tabnext<CR>", opts)
map("n", "<A-->", "<Cmd>6tabnext<CR>", opts)
map("n", "è", "<Cmd>7tabnext<CR>", opts)
map("n", "<A-_>", "<Cmd>8tabnext<CR>", opts)
map("n", "<A-ç>", "<Cmd>9tabnext<CR>", opts)
map("n", "à", "<Cmd>$tabnext<CR>", opts)

-- BUFFERS
map("c", "w!!<CR>", "w ! sudo tee % > /dev/null<CR>", opts) -- write as sudo
map({ "n", "v", "c", "i" }, "<C-s>", "<Cmd>w<CR>", opts)    -- write shortcut

-- DIAGNOSTICS
map("n", "ds", vim.diagnostic.open_float, opts) -- open diagnostic window
map("n", "dn", vim.diagnostic.goto_next, opts)  -- goto next diagnostic
map("n", "dp", vim.diagnostic.goto_prev, opts)  -- goto prev diagnostic

-- TREE SITTER
local treesitter = vim.treesitter
local api = vim.api
local cursor = require("lib.win.cursor")
local yield_iter = require("lib.yield_iter")

local poscmp = function(pos1, pos2)
	local line1, col1 = table.unpack(pos1)
	local line2, col2 = table.unpack(pos2)

	if line1 < line2 then
		return -1
	elseif line1 > line2 then
		return 1
	else
		if col1 < col2 then
			return -1
		elseif col1 > col2 then
			return 1
		else
			return 0
		end
	end
end

local node_depth_first
node_depth_first = function(node, fn)
	if not node then return end

	for child in node:iter_children() do
		node_depth_first(child, fn)
	end

	fn(node)
end

map("n", "n", function() -- goto next treesitter ast node.
	local pos = { cursor.pos() }
	pos[1] = pos[1] - 1    -- Convert to zero based cursor pos.

	local node = treesitter.get_node()
	if not node then return end

	local root = node:tree():root()

	local node_iter = yield_iter.new(function(yield)
		node_depth_first(root, yield)
	end)

	for n in node_iter do
		---@diagnostic disable-next-line: undefined-field
		if poscmp({ n:start() }, pos) > 0 then
			---@diagnostic disable-next-line: undefined-field
			local line, col = n:start()
			api.nvim_win_set_cursor(0, { line + 1, col })
			break
		end
	end
end, opts)

local node_reverse_depth_first
node_reverse_depth_first = function(node, fn)
	if not node then return end

	for i = node:child_count(), 0, -1 do
		local child = node:child(i)
		node_reverse_depth_first(child, fn)
	end

	fn(node)
end

map("n", "N", function() -- goto previous treesitter ast node.
	local pos = { cursor.pos() }
	pos[1] = pos[1] - 1    -- Convert to zero based cursor pos.

	local node = treesitter.get_node()
	if not node then return end

	local root = node:tree():root()

	local node_iter = yield_iter.new(function(yield)
		node_reverse_depth_first(root, yield)
	end)

	for n in node_iter do
		---@diagnostic disable-next-line: undefined-field
		if poscmp({ n:start() }, pos) < 0 then
			---@diagnostic disable-next-line: undefined-field
			local line, col = n:start()
			api.nvim_win_set_cursor(0, { line + 1, col })
			break
		end
	end
end, opts)
