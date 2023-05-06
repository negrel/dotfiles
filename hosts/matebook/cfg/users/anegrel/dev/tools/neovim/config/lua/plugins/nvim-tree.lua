require("nvim-tree").setup {
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "h",     action = "prev_sibling" },
        { key = "l",     action = "next_sibling" },
        { key = "c",     action = "collapse_all" },
        { key = "<C-e>", action = "cd" },
      }
    }
  },
  renderer = {
    icons = {
      git_placement = "signcolumn",
      modified_placement = "signcolumn",
    }
  }
}

-- KEYMAPS
local map = vim.keymap.set
local opts = { silent = true }

-- Toggle file explorer
map({ "n", "v", "c", "i" }, "<C-b>", "<Cmd>NvimTreeToggle<CR>", opts)
