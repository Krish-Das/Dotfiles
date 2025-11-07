local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/nvim-lua/plenary.nvim",
    data = {
      event = "DeferredUIEnter",
      dep_of = { "harpoon", "neogit" },
    },
  },
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    name = "harpoon",
    version = "harpoon2",
    data = {
      event = "DeferredUIEnter",
      after = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        local map = require("config.keymap_utils")
        map("<leader>ha", function()
          harpoon:list():add()
        end, "Harpoon: [H]arpoon [A]dd buffer")
        map("<leader>ho", function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, "Harpoon: [H]arpoon [O]pen quick menu")

        map("<leader>1", function()
          harpoon:list():select(1)
        end, "Harpoon: Select item [1]")
        map("<leader>2", function()
          harpoon:list():select(2)
        end, "Harpoon: Select item [2]")
        map("<leader>3", function()
          harpoon:list():select(3)
        end, "Harpoon: Select item [3]")
        map("<leader>4", function()
          harpoon:list():select(4)
        end, "Harpoon: Select item [4]")
        map("<leader>h<", function()
          harpoon:list():prev()
        end, "Harpoon: Select previous item")
        map("<leader>h>", function()
          harpoon:list():next()
        end, "Harpoon: Select next item")
      end,
    },
  },
})
