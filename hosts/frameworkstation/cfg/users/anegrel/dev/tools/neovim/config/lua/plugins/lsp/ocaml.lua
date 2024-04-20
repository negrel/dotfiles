local lsp = require("plugins.lsp")

require("lspconfig").ocamllsp.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,

	settings = {}
}
