return {
  "folke/tokyonight.nvim",
  lazy = true,

  config = function()
    require("tokyonight").setup {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },

      on_colors = function() end,
      on_highlights = function() end,
    }
  end,
}
