local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/j-hui/fidget.nvim",
    data = {
      event = "VimEnter",
      after = function()
        require("fidget").setup({})
      end,
    },
  },
  {
    src = "https://github.com/NeogitOrg/neogit",
    data = {
      keys = { "<leader>gg" },
      after = function()
        local neogit = require("neogit")
        neogit.setup({
          kind = "floating",
          floating = {
            height = 0.8,
          },
          integrations = {
            mini_pick = true,
          },
        })
        local map = require("config.keymap_utils")
        map("<leader>gg", function()
          neogit.open()
        end, "Open Git UI (Neogit)")
      end,
    },
  },
})
