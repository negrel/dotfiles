local lsp = require("plugins.lsp")

local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

-- code action sources
local code_actions = null_ls.builtins.code_actions

-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics

-- formatting sources
local formatting = null_ls.builtins.formatting

-- hover sources
local hover = null_ls.builtins.hover

-- completion sources
local completion = null_ls.builtins.completion

local sources = {
	diagnostics.staticcheck,

	formatting.prettier.with {
		"vue",
		"css",
		"scss",
		"less",
		"html",
		"json",
		"jsonc",
		"yaml",
		"markdown",
		"markdown.mdx",
		"graphql",
		"handlebars"
	},
	formatting.standardjs,
	formatting.standardts,
}

null_ls.setup {
	on_attach = lsp.on_attach,
	sources = sources
}
