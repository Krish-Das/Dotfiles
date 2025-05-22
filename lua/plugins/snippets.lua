return {
  {
    "folke/lazydev.nvim",
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {},
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
}

-- {
-- "rafamadriz/friendly-snippets",
--   config = function()
--     require("luasnip.loaders.from_vscode").lazy_load()
--   end
-- }
-- {
--   "mlaursen/vim-react-snippets",
--   config = function()
--     require("vim-react-snippets").lazy_load()
--     local config = require("vim-react-snippets.config")
--     config.readonly_props = false
--   end,
-- }
