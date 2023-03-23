require("nvim-treesitter.configs").setup {
		ensure_installed = { "c", "rust", "lua", "go", "nix" },
		highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
		},
		indent = {
				enable = true
		}
}
