local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/L3MON4D3/LuaSnip",
    data = {
      keys = { { "<C-e>", mode = "i" } },
      after = function()
        local ls = require("luasnip")
        ls.setup({ enable_autosnippets = true })
        require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets/" })

        local map = require("config.keymap_utils")

        map("<C-e>", function()
          ls.expand()
        end, "Expand snippet", { "i" })

        map("<C-l>", function()
          ls.jump(1)
        end, "Jump to next snippet field", { "i", "s" })

        map("<C-h>", function()
          ls.jump(-1)
        end, "Jump to previous snippet field", { "i", "s" })
      end,
    },
  },
})
