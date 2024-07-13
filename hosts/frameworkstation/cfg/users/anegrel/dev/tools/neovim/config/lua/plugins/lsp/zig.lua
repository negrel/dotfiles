local lsp = require("plugins.lsp")

require("lspconfig").zls.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,
}
