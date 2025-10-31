local map = require("config.keymap_utils")

require("plugins.lsp")
require("config.treesitter")
require("config.formatter")

vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  -- themes
  { src = "https://github.com/marko-cerovac/material.nvim" },
})

require("mini.pick").setup()
require("oil").setup()

-- Set colorscheme and transparency
vim.cmd.colorscheme("material-deep-ocean")
vim.cmd.highlight("statusline guibg=NONE")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- Some keybinds
map("<leader>ff", "<cmd>Pick files<CR>", "Open file picker")
map("<leader>-", "<cmd>Oil<CR>", "Open directory in Oil buffer")
map("<leader>rr", ":update<CR>:source<CR>", "Yank current line to system clipboard")
