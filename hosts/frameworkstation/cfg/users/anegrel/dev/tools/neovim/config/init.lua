-- LEADER
vim.g.mapleader = ","
vim.g.localleader = ";"

-- IMPORTS
require("vars") -- Variables
require("opts") -- Options
require("keys") -- Keymaps
require("plug") -- Plugins

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		local argc = vim.fn.argc()

		if argc == 0 then
			vim.cmd("terminal")
		elseif argc == 1 then
			local arg = vim.fn.argv(0)
			if vim.fn.isdirectory(arg) == 1 then
				vim.api.nvim_set_current_dir(arg)
				vim.cmd("terminal")
			else
				local parent = vim.fs.dirname(arg)
				vim.api.nvim_set_current_dir(parent)
			end
		end
	end
})
