local fn = vim.fn
local ensure_packer = function()
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

require("packer").startup({function(use)
	-- packer manages itself
	use "wbthomason/packer.nvim"

	-- theme
	use { "Mofiqul/dracula.nvim", as = "dracula" }

	-- IDE
	-- syntax highlight
	use {
		"nvim-treesitter/nvim-treesitter",
		config = [[require("plugins.nvim-treesitter")]],
		run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
	}

	-- File explorer
	use {
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- for file icons
		},
		config = [[require("plugins.nvim-tree")]],
		tag = "nightly"
	}

	-- Tabs
	use {
		"romgrk/barbar.nvim",
		config = [[require("plugins.barbar")]],
		requires = { "kyazdani42/nvim-web-devicons" }
	}

	-- Bar
	use {
		"nvim-lualine/lualine.nvim",
		config = [[require("lualine").setup{}]],
		requires = { "kyazdani42/nvim-web-devicons", opt = true }
	}

	-- Quick finder
	use {
		"nvim-telescope/telescope.nvim", tag = "0.1.0",
		config = [[require("plugins.telescope")]],
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" }
		}
	}

	-- Autocompletion
	use { -- Autocompletion plugin
		"hrsh7th/nvim-cmp",
		config = [[require("plugins.nvim-cmp")]]
	}
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "saadparwaiz1/cmp_luasnip" -- Snippets source for nvim-cmp
	use "L3MON4D3/LuaSnip" -- Snippets plugin

	-- Collection of lua modules
	use {
		"echasnovski/mini.nvim",
		config = [[require("plugins.mini")]]
	}

	-- LSP
	-- Setup
	use "williamboman/mason.nvim" -- LSP servers installer
	use "williamboman/mason-lspconfig.nvim" -- plugin for lspconfig
	use "hrsh7th/cmp-nvim-lsp" -- LSP source for nvim-cmp
	use { -- LSP config
		"neovim/nvim-lspconfig",
		config = [[require("plugins.lsp")]]
	}

	-- Rust
	use {
		"simrat39/rust-tools.nvim",
		config = [[require("plugins.lsp.rust")]],
	}

	-- Eww yuck
	use {
		"elkowar/yuck.vim",
		ft = { "yuck" }
	}

	-- Earthly
	use {
		"earthly/earthly.vim"
	}
	-- Dart & Flutter
	use {
		"dart-lang/dart-vim-plugin",
		ft = { "dart" }
	}
	use {
		"akinsho/flutter-tools.nvim",
		requires = "nvim-lua/plenary.nvim"
	}

	-- Bootstrap packer
	if packer_bootstrap then
		require("packer").sync()
	end
end, config = {
	compile_path = fn.stdpath("data") .. "/plugin/packer_compiled.lua"
}})

require("packer").compile()

require("plugins.lsp.lua")
require("plugins.lsp.yaml")
require("plugins.lsp.bash")
require("plugins.lsp.bash")
require("plugins.lsp.go")
require("plugins.lsp.json")
require("plugins.lsp.c")
require("plugins.lsp.d")
require("plugins.lsp.html")
require("plugins.lsp.markdown")
require("plugins.lsp.python")
require("plugins.lsp.flutter")
require("plugins.lsp.nix")
require("plugins.lsp.deno")
