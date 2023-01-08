require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		"sumneko_lua",
		"rust_analyzer",
		"clangd",
		"gopls",
		"denols",
		"yamlls",
		"bashls",
		"gopls",
		"jsonls",
		"clangd",
		"serve_d",
		"html",
		"zk", -- Markdown
		"pyright",
		"sqlls",
		"rnix"
	},
	automatic_installation = true
}

local win = require("lib.win")

local M = {}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- KEYMAPS
local map = vim.keymap.set

M.on_attach = function(_, bufnr)
	local opts = { silent = true, buffer = bufnr }
	map("n", "gd", vim.lsp.buf.definition, opts)
	map("n", "gD", vim.lsp.buf.declaration, opts)
	map("n", "gi", vim.lsp.buf.implementation, opts)
	map("n", "gr", vim.lsp.buf.references, opts)
	map("n", "<C-Space>", vim.lsp.buf.hover, opts)
	map("n", "hs", vim.lsp.buf.signature_help, opts)
	map("n", "rn", vim.lsp.buf.rename, opts)
	map("n", "ca", vim.lsp.buf.code_action, opts)
	map({ "n", "i" }, "<A-F>", vim.lsp.buf.format, opts)
	vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
end

-- override open window function
local open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
	opts = opts or {}

	local bufnr, winnr = open_floating_preview(contents, syntax, opts)

	-- scroll to scrolloff so first scroll is not useless
	win.cursor.scroll_by(winnr, 4)

	-- add keymaps for scrolling
	map("n", "<A-f>", function()
		if vim.api.nvim_win_is_valid(winnr) then
			win.cursor.scroll_by(winnr, 4)
			win.shift_viewport(winnr, "top")
		end
	end, {})
	map("n", "<A-d>", function()
		if vim.api.nvim_win_is_valid(winnr) then
			win.cursor.scroll_by(winnr, -4)
			win.shift_viewport(winnr, "top")
		end
	end, {})

	return bufnr, winnr
end

M.root_dir = require("lspconfig").util.root_pattern(".git")

return M
