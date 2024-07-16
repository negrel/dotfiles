local lsp = require("plugins.lsp")

require("lspconfig").gopls.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,

	settings = {
		gopls = {
			usePlaceholders = true,
			codelenses = {
				gc_details = true
			},
		}
	}
}
