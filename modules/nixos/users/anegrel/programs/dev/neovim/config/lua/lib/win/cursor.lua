local api = vim.api
local buf = require("lib.buf")

local M = {}

if table.unpack == nil then
	table.unpack = unpack
end

M.get_pos = function(winnr)
	return table.unpack(api.nvim_win_get_cursor(winnr or 0))
end

M.scroll_by = function(winnr, offset)
	winnr = winnr or 0
	local row, col = table.unpack(api.nvim_win_get_cursor(winnr))
	row = row + offset
	row = math.min(buf.line_count(buf.of_win(winnr)), row)
	row = math.max(1, row)

	api.nvim_win_set_cursor(winnr, { row, col })
end

M.scroll_to = function(winnr, row)
	winnr = winnr or 0
	local _, col = M.get_pos(winnr)
	row = math.min(buf.line_count(buf.of_win(winnr)), row)
	row = math.max(1, row)

	api.nvim_win_set_cursor(winnr, { row, col })
end

return M
