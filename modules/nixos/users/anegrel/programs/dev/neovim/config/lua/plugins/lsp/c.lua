local lsp = require("plugins.lsp")

require("lspconfig").clangd.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,

	settings = {}
}
