local lsp = require("plugins.lsp")

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- lspconfig.lua_ls.setup {
-- 	capabilities = lsp.capabalities,
-- 	on_attach = lsp.on_attach,
--
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = {
-- 				globals = { "vim" }
-- 			},
-- 			format = {
-- 				enable = true,
-- 			}
-- 		}
-- 	}
-- }

if not configs.allelua then
	configs.allelua = {
		default_config = {
			cmd = { "allelua", "lsp" },
			filetypes = { "lua" },
			root_dir = util.find_git_ancestor,
			settings = {},
		}
	}
end

lspconfig.allelua.setup {
	capabilities = lsp.capabalities,
	on_attach = lsp.on_attach,
	settings = {}
}
