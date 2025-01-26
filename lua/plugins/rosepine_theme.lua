return {
  "rose-pine/neovim",
  name = "rose-pine",

  lazy = true,

  config = function()
    require("rose-pine").setup {
      variant = "main", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      extend_background_behind_borders = false,
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    }
  end,
}
