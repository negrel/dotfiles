local lsp = require("plugins.lsp")

require("lspconfig").rnix.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,

	settings = {}
}
