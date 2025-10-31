require("plugins.lsp")
require("config.treesitter")
require("config.formatter")
require("plugins.mini_nvim")
require("plugins.oil")

vim.pack.add({
  { src = "https://github.com/marko-cerovac/material.nvim" },
})

-- Set colorscheme and transparency
vim.cmd.colorscheme("material-deep-ocean")
vim.cmd.highlight("statusline guibg=NONE")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
