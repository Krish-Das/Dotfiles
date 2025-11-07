local lze = require("plugin-helper")
lze.add({
  -- {
  --   src = "https://github.com/nvim-mini/mini.icons",
  --   lazy = "VeryLazy",
  --   data = {
  --     dep_of = "fyler.nvim",
  --   },
  -- },
  {
    src = "https://github.com/A7Lavinraj/fyler.nvim",
    version = "stable",
    data = {
      keys = "<leader>-",
      after = function()
        local fyler = require("fyler")
        fyler.setup({
          close_on_select = true,
          confirm_simple = false,
          delete_to_trash = true,
          icon_provider = "none", -- depends on mini.icons or web-devicons
          icon = {
            directory_collapsed = "􀰑 ",
            directory_empty = "􁆭 ",
            directory_expanded = "􀄵 ",
          },
          win = {
            kind = "split_left_most",
          },
        })

        local map = require("config.keymap_utils")
        map("<leader>-", function()
          fyler.toggle()
        end, "Toggle Oil")
      end,
    },
  },
})
