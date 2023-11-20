local lsp = require("plugins.lsp")

require("lspconfig").texlab.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,

	settings = {}
}
