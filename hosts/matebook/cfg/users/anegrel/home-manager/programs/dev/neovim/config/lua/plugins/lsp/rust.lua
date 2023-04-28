local lsp = require("plugins.lsp")
require("rust-tools").setup({
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
})
