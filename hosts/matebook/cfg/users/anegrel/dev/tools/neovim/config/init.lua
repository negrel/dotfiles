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
		if vim.fn.argc() == 0 then
			vim.cmd("terminal")
		end
	end
})
