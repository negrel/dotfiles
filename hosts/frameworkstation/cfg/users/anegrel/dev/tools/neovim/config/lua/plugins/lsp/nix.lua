local lsp = require("plugins.lsp")

require("lspconfig").nixd.setup {
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
