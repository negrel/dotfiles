local opt = vim.opt

-- MOUSE
opt.mouse = "a"

-- CONTEXT
opt.colorcolumn = "80" -- str:  Show col for max line length
opt.number = true -- bool: Show line numbers
opt.relativenumber = true -- bool: Show relative line numbers
opt.scrolloff = 4 -- int:  Min num lines of context
opt.signcolumn = "yes" -- str:  Show the sign column

-- FILETYPES
opt.encoding = "utf8" -- str:  String encoding to use
opt.fileencoding = "utf8" -- str:  File encoding to use

-- THEME
opt.syntax = "ON" -- str:  Allow syntax highlighting
opt.termguicolors = true -- bool: If term supports ui color then enable
vim.cmd [[colorscheme dracula]] -- str:  Change colorscheme/theme

-- SEARCH
opt.ignorecase = true -- bool: Ignore case in search patterns
opt.smartcase = true -- bool: Override ignorecase if search contains capitals
opt.incsearch = true -- bool: Use incremental search
opt.hlsearch = false -- bool: Highlight search matches

-- WHITESPACE
opt.shiftwidth = 2 -- num:   Size of an indent
opt.tabstop = 2 -- num:   Size of a tab
opt.list = true -- bool:  Show whitespaces
opt.listchars = { -- table: Whitespace charactes
	multispace = "·", lead = "·", trail = "·", tab = "➞ "
}

-- SPLITS
opt.splitright = true -- bool: Place new window to right of current one
opt.splitbelow = true -- bool: Place new window below the current one
