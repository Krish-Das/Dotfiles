local map = require("config.keymap_utils")

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("<Esc>", "<cmd>nohlsearch<CR>", "Clear highlights on search")
map("<leader>a", "ggVG", "Select all")
