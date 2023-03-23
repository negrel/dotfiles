local lsp = require("plugins.lsp")

require("lspconfig").html.setup {
		capabilities = lsp.capabalities,
		on_attach = lsp.on_attach,

		settings = {}
}
