local lsp = require("plugins.lsp")

require("lspconfig").serve_d.setup {
		capabilities = lsp.capabalities,
		on_attach = lsp.on_attach,

		settings = {}
}
