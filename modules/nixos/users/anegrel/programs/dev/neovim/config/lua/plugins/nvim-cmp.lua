local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup {
		snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
		},
		mapping = cmp.mapping.preset.insert({
				["<A-J>"] = cmp.mapping.select_next_item(),
				["<A-K>"] = cmp.mapping.select_prev_item(),
				["<A-d>"] = cmp.mapping.scroll_docs( -4),
				["<A-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
				},
		}),
		sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" }
		}
}
