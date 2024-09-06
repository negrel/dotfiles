local lsp = require("plugins.lsp")

require("lspconfig").harper_ls.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,

	settings = {
		["harper-ls"] = {
			codeActions = {
				forceStable = true
			}
		}
	}
}
