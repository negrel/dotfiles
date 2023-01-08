local lsp = require("plugins.lsp")

local nvim_lsp = require("lspconfig")

nvim_lsp.denols.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
	settings = {}
}
