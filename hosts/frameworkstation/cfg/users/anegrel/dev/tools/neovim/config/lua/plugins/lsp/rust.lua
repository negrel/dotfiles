local lsp = require("plugins.lsp")
vim.g.rustaceanvim = {
	server = {
		capabilities = lsp.capabilities,
		on_attach = lsp.on_attach,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy"
				}
			}
		}
	},
}
