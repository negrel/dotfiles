local lsp = require("plugins.lsp")

require("lspconfig").sqlls.setup {
	root_dir = lsp.root_dir,
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,

	settings = {}
}
