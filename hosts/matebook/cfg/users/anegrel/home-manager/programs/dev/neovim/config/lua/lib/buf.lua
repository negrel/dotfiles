local api = vim.api

local M = {}

M.of_win = function(winnr)
	return api.nvim_win_get_buf(winnr or 0)
end

M.line_count = function(bufnr)
	return api.nvim_buf_line_count(bufnr or 0)
end

return M
