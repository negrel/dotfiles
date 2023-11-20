local lsp = require("plugins.lsp")

require("lspconfig").yamlls.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,
}
