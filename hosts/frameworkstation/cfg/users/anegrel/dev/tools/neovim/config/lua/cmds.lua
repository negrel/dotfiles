local api = vim.api

api.nvim_create_user_command("Scratch", function()
	local bufnr = api.nvim_create_buf(false, true)
	api.nvim_win_set_buf(0, bufnr)
end, {})
