return {
  "marko-cerovac/material.nvim",
  lazy = "true",
  event = "VeryLazy",
  opts = {
    contrast = {
      sidebars = true,
      cursor_line = true,
      non_current_windows = false,
    },

    styles = {
      comments = { italic = true },
      conditionals = { italic = true },
      functions = { bold = true },
    },
    plugins = {
      "neo-tree",
    },
    disable = {
      background = false,
    },
    lualine_style = "stealth",
  },
}
