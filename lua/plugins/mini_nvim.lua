vim.pack.add({
  "https://github.com/nvim-mini/mini.pick",
})
require("mini.pick").setup()

local map = require("config.keymap_utils")
map("<leader>ff", "<cmd>Pick files<CR>", "[F]ind [F]iles")
map("<leader><leader>", "<cmd>Pick buffers<CR>", "[ ] Find existing buffers")
map("<leader>fg", "<cmd>Pick grep_live<CR>", "[F]ind by [G]rep")
map("<leader>fh", "<cmd>Pick help<CR>", "[F]ind [H]elp")
