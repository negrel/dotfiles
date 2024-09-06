local lsp = require("plugins.lsp")

local nvim_lsp = require("lspconfig")

-- Deno
nvim_lsp.denols.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,
	root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
	single_file_support = false,
	settings = {}
}

-- KEYMAPS
local map = vim.keymap.set

-- Nodejs / Bun
nvim_lsp.eslint.setup {
	capabilities = lsp.capabalities,
	on_attach = function(client, bufnr)
		lsp.on_attach(client, bufnr)
		map(
			{ "n", "i" },
			"<A-F>",
			"<Cmd>EslintFixAll<CR>",
			{ silent = true, buffer = bufnr }
		)

		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	root_dir = nvim_lsp.util.root_pattern(
		".eslintrc",
		".eslintrc.json",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.mjs"
	),
	settings = {}
}

nvim_lsp.ts_ls.setup {
	capabilities = lsp.capabalities,
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		lsp.on_attach(client, bufnr)
	end,
	root_dir = nvim_lsp.util.root_pattern("tsconfig.json", "package.json", "bun.lockb"),
	single_file_support = false,
	settings = {}
}
