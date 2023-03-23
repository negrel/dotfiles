local lsp = require("plugins.lsp")

require("lspconfig").bashls.setup {
		capabilities = lsp.capabalities,
		on_attach = lsp.on_attach,

		settings = {}
}
