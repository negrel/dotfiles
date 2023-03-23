local lsp = require("plugins.lsp")

require("lspconfig").lua_ls.setup {
		capabilities = lsp.capabalities,
		on_attach = lsp.on_attach,

		settings = {
				Lua = {
						diagnostics = {
								globals = { "vim" }
						},
						format = {
								enable = true,
						}
				}
		}
}
