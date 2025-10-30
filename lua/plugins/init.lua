local map = require("config.keymap_utils")

require("plugins.lsp")

vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  -- themes
  { src = "https://github.com/marko-cerovac/material.nvim" },
})

require("mini.pick").setup()
require("oil").setup()
require("nvim-treesitter.configs").setup({
  ensure_installed = { "typescript", "javascript", "css" },
  auto_install = false,
  ignore_install = {},
  modules = {},
  sync_install = false,
  highlight = { enable = true },
})

-- Set colorscheme and transparency
vim.cmd.colorscheme("material-deep-ocean")
vim.cmd.highlight("statusline guibg=NONE")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- Some keybinds
map("<leader>e", "<cmd>Pick files<CR>", "Open file picker")
map("<leader>-", "<cmd>Oil<CR>", "Open directory in Oil buffer")
map("<leader>rr", ":update<CR>:source<CR>", "Yank current line to system clipboard")
map("<leader>fm", function()
  vim.lsp.buf.format()
end, "Format current buffer via LSP")
