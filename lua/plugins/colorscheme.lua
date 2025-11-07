local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
    data = {
      event = "VimEnter",
      after = function()
        vim.cmd.colorscheme("catppuccin-frappe")
        vim.cmd.highlight("statusline guibg=NONE")
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
      end,
    },
  },
})
