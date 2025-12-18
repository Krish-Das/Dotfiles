return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = "VeryLazy",
  },
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = "VeryLazy",
    config = function()
      local dracula = require("dracula")
      local colors = dracula.colors()
      dracula.setup({
        transparent_bg = true,
        italic_comment = true,
        colors = { selection = colors.bg },
      })
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    opts = {
      options = {
        styles = { comments = "italic", keywords = "bold", types = "italic,bold" },
      },
    },
    name = "github-theme",
    config = function(_, opts)
      require("github-theme").setup(opts)
      vim.cmd.colorscheme("github_dark")
    end,
  },
}
