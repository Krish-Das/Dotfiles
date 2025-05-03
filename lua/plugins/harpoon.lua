local map = require("config.keymap_utils")

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

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

    -- Toggle previous & next buffers stored within Harpoon list
    map("<leader>h<", function()
      harpoon:list():prev()
    end, "Harpoon: Select previous item")
    map("<leader>h>", function()
      harpoon:list():next()
    end, "Harpoon: Select next item")
  end,
}
