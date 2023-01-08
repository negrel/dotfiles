local lsp = require("plugins.lsp")

local nvim_lsp = require("lspconfig")

-- Deno
nvim_lsp.denols.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,
	root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
	settings = {}
}

-- KEYMAPS
local map = vim.keymap.set

-- Nodejs
nvim_lsp.eslint.setup {
	capabilities = lsp.capabalities,
	on_attach = function(client, bufnr)
		lsp.on_attach(client, bufnr)
		map({ "n", "i" }, "<A-F>", "<Cmd>EslintFixAll<CR>", { silent = true, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	settings = {}
}

nvim_lsp.tsserver.setup {
	capabilities = lsp.capabalities,
	on_attach = function (client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		lsp.on_attach(client, bufnr)
	end,
	settings = {}
}

