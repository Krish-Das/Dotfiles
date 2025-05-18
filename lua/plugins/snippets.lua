return {
  {
    "folke/lazydev.nvim",
  },
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = (function()
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      {
        "mlaursen/vim-react-snippets",
        config = function()
          require("vim-react-snippets").lazy_load()
          local config = require("vim-react-snippets.config")
          config.readonly_props = false
        end,
      },
    },
    opts = {},
  },
}
