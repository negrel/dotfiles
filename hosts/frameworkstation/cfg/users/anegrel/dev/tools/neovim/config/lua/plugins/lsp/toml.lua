local lsp = require("plugins.lsp")

require("lspconfig").taplo.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,
}
