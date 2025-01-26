local material_nvim = {
  {
    "marko-cerovac/material.nvim",
    lazy = true,

    config = function()
      require("material").setup({
        disable = {
          colored_cursor = true,
          background = true,
        },
        styles = {
          comments = { italic = true },
          strings = nil,
          keywords = nil,
          functions = { bold = true },
          variables = nil,
          operators = nil,
          types = nil,
        },
        high_visibility = {
          lighter = true,
          darker = true,
        },
        contrast = {
          cursor_line = true,
        },
        lualine_style = "stealth",
        async_loading = true,
      })

      -- :lua require("material.functions").find_style()
      vim.g.material_style = "deep ocean" -- darker, lighter, oceanic, palenight, "deep ocean"

      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },
}

return material_nvim

