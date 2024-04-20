local api = vim.api
local buf = require("lib.buf")

local M = {
	cursor = require("lib.win.cursor")
}

local get_winwidth = api.nvim_win_get_width
local get_winheight = api.nvim_win_get_height

M.get_width = function(winnr)
	return get_winwidth(winnr or 0)
end

M.get_height = function(winnr)
	return get_winheight(winnr or 0)
end

M.is_vertical = function(winnr, ratio)
	return M.get_width(winnr) / M.get_height(winnr) < (ratio or 1)
end

M.is_horizontal = function(winnr, ratio)
	return not M.is_vertical(winnr, ratio)
end

M.get_buf = buf.of_win

M.content_height = function(winnr)
	if winnr == nil then
		return buf.line_count()
	else
		return buf.line_count(M.get_buf(winnr))
	end
end

M.scroll_by_page = function(winnr, count)
	count = count or 1
	M.cursor.scroll_by(winnr, count * M.get_height(winnr))
end

M.scroll_to_eop = function(winnr, offset)
	offset = offset or 0
	M.cursor.scroll_to(winnr, M.get_height(winnr) + offset)
end

M.scroll_to_eof = function(winnr, offset)
	offset = offset or 0
	M.cursor.scroll_to(winnr, M.get_content_height(winnr) + offset)
end

M.shift_viewport = function(winnr, position)
	local cmd = ({ top = "zt", center = "zz", bottom = "ze" })[position]
	local bufnr = M.get_buf(winnr)
	local curpos = M.cursor.pos(winnr)

	api.nvim_buf_call(bufnr, function()
		api.nvim_command("normal!" .. tostring(curpos) .. cmd)
	end)
end

return M
