local lsp = require("plugins.lsp")

require("lspconfig").jsonls.setup {
		capabilities = lsp.capabalities,
		on_attach = lsp.on_attach,

		settings = {}
}
