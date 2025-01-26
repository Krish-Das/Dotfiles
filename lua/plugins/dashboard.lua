-- NOTE: docs:
-- https://github.com/goolord/alpha-nvim
-- https://github.com/goolord/alpha-nvim/blob/main/doc/alpha.txt
--
return {
  "goolord/alpha-nvim",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("alpha").setup(require("alpha.themes.theta").config)
  end,
}
