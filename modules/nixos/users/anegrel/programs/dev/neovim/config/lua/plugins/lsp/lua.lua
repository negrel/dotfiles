local lsp = require("plugins.lsp")

require("lspconfig").sumneko_lua.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "tab"
				}
			}
		}
	}
}
