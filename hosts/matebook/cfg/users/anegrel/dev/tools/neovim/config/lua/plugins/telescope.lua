local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions
require("telescope").setup {
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<A-j>"] = actions.move_selection_next,
				["<A-k>"] = actions.move_selection_previous,
				["<A-f>"] = actions.preview_scrolling_down,
				["<A-d>"] = actions.preview_scrolling_up
			},
		},
		preview = {
			mime_hook = function(filepath, bufnr, opts)
				---@diagnostic disable-next-line: redefined-local
				local is_image = function(filepath)
					local image_extensions = { 'png', 'jpg', 'jpeg', 'webp', 'avif' } -- Supported image formats
					local split_path = vim.split(filepath:lower(), '.', { plain = true })
					local extension = split_path[#split_path]
					return vim.tbl_contains(image_extensions, extension)
				end
				if is_image(filepath) then
					local term = vim.api.nvim_open_term(bufnr, {})
					local function send_output(_, data, _)
						for _, d in ipairs(data) do
							vim.api.nvim_chan_send(term, d .. '\r\n')
						end
					end
					vim.fn.jobstart(
						{
							'catimg', filepath -- Terminal image viewer command
						},
						{ on_stdout = send_output, stdout_buffered = true, pty = true })
				else
					require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
				end
			end
		},
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
		},
		grep_string = {
			hidden = true
		}
	},
	extensions = {
		file_browser = {
			mappings = {
				["i"] = {
					["<A-n>"] = fb_actions.create,
					["<A-r>"] = fb_actions.rename,
					["<A-y>"] = fb_actions.copy,
					["<A-d>"] = fb_actions.remove,
					["<A-w>"] = fb_actions.goto_cwd,
					["<A-h>"] = fb_actions.goto_parent_dir,
					["<A-l>"] = actions.select_default
				}
			}
		}
	}
}
require("telescope").load_extension "file_browser"

local builtin = require("telescope.builtin")
builtin.file_browser = require("telescope").extensions.file_browser.file_browser

local win = require("lib.win")
local telescope = function(cmd)
	args = args or {}
	args.width = args.width or 0.75
	args.height = args.height or 0.85
	cmd = builtin[cmd]

	return function()
		if win.is_vertical(nil, 2.55) then
			args.layout_strategy = "vertical"
		else
			args.layout_strategy = "horizontal"
		end

		cmd(args)
	end
end

-- KEYMAPS
local map = vim.keymap.set
local opts = { silent = true }

map("n", "<Leader>ff", telescope("find_files"), opts)
map("n", "<Leader>gg", telescope("live_grep"), opts)
map("n", "<Leader>hc", telescope("command_history"), opts)
map("n", "<Leader>hs", telescope("search_history"), opts)
map("n", "<Leader>hh", telescope("help_tags"), opts)
map("n", "<Leader>hk", telescope("keymaps"), opts)
map("n", "<Leader>b", telescope("buffers"), opts)
map("n", "<Leader>fb", telescope("file_browser"), opts)
