local lsp = require("plugins.lsp")

require("lspconfig").nil_ls.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,

	settings = {
		['nil'] = {
			formatting = {
				command = { "nixpkgs-fmt" },
			},
		},
	}
}
