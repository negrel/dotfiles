local fn = vim.fn
local ensure_packer = function()
	local install_path = fn.stdpath("data")
		.. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system {
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		}
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

require("packer").startup {
	function(use)
		-- packer manages itself
		use("wbthomason/packer.nvim")

		-- IDE
		-- syntax highlight
		use {
			"nvim-treesitter/nvim-treesitter",
			config = [[require("plugins.nvim-treesitter")]],
			run = function()
				require("nvim-treesitter.install").update { with_sync = true }
			end,
		}

		-- Hex colors
		use {
			"norcalli/nvim-colorizer.lua",
			config = [[require("plugins.nvim-colorizer")]],
		}

		-- Bar
		use {
			"nvim-lualine/lualine.nvim",
			config = [[require("lualine").setup{
				sections = {
					lualine_c = {
						{ 'filename', path = 1 }
					}
				}
			}]],
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		}

		-- Quick finder
		use {
			"nvim-telescope/telescope.nvim",
			config = [[require("plugins.telescope")]],
			requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		}
		use {
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		}

		-- Autocompletion
		use { -- Autocompletion plugin
			"hrsh7th/nvim-cmp",
			config = [[require("plugins.nvim-cmp")]],
		}
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
		use("L3MON4D3/LuaSnip") -- Snippets plugin

		-- Git integration
		use {
			"lewis6991/gitsigns.nvim",
			config = [[require("gitsigns").setup()]],
		}

		-- LSP
		-- Setup
		use("williamboman/mason.nvim") -- LSP servers installer
		use("williamboman/mason-lspconfig.nvim") -- plugin for lspconfig
		use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
		use { -- LSP config
			"neovim/nvim-lspconfig",
			config = [[require("plugins.lsp")]],
		}

		use {
			"nvimtools/none-ls.nvim",
			config = [[require("plugins.none-ls")]],
		}

		-- Rust
		use {
			"mrcjkb/rustaceanvim",
			config = [[require("plugins.lsp.rust")]],
			ft = { "rust" },
		}

		-- Eww yuck
		use {
			"elkowar/yuck.vim",
			ft = { "yuck" },
		}

		-- Earthly
		use {
			"earthly/earthly.vim",
		}
		-- Dart
		-- use {
		-- 	"dart-lang/dart-vim-plugin",
		-- 	ft = { "dart" }
		-- }
		-- flutter
		use {
			"akinsho/flutter-tools.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"stevearc/dressing.nvim", -- optional for vim.ui.select
			},
		}

		-- Collection of lua modules
		use {
			"echasnovski/mini.nvim",
			config = [[require("plugins.mini")]],
		}

		-- Gruvbox theme
		use {
			"sainnhe/gruvbox-material",
			lazy = false,
			priority = 1000,
			config = function()
				vim.g.gruvbox_material_background = "hard"
				vim.g.gruvbox_material_float_style = "dim"
				vim.g.gruvbox_material_enable_italic = true
				vim.cmd.colorscheme("gruvbox-material")
			end,
		}

		-- Bootstrap packer
		if packer_bootstrap then require("packer").sync() end
	end,
	config = {
		compile_path = fn.stdpath("data") .. "/plugin/packer_compiled.lua",
	},
}

require("packer").compile()

require("plugins.lsp.bash")
require("plugins.lsp.c")
require("plugins.lsp.css")
require("plugins.lsp.d")
require("plugins.lsp.elixir")
require("plugins.lsp.flutter")
require("plugins.lsp.go")
require("plugins.lsp.harper")
require("plugins.lsp.html")
require("plugins.lsp.javascript")
require("plugins.lsp.json")
require("plugins.lsp.latex")
require("plugins.lsp.lua")
require("plugins.lsp.markdown")
require("plugins.lsp.nix")
require("plugins.lsp.ocaml")
require("plugins.lsp.python")
require("plugins.lsp.toml")
require("plugins.lsp.yaml")
require("plugins.lsp.zig")
