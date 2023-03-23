local lsp = require("plugins.lsp")

require("lspconfig").zk.setup {
		capabilities = lsp.capabalities,
		on_attach = lsp.on_attach,

		settings = {}
}
