return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Harpoon: [H]arpoon [A]dd buffer" })
    vim.keymap.set("n", "<leader>ho", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon: [H]arpoon [O]pen quick menu" })

    vim.keymap.set("n", "<leader>1", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon: Select item [1]" })
    vim.keymap.set("n", "<leader>2", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon: Select item [2]" })
    vim.keymap.set("n", "<leader>3", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon: Select item [3]" })
    vim.keymap.set("n", "<leader>4", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon: Select item [4]" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>h<", function()
      harpoon:list():prev()
    end, { desc = "Harpoon: Select previous item" })
    vim.keymap.set("n", "<leader>h>", function()
      harpoon:list():next()
    end, { desc = "Harpoon: Select next item" })
  end,
}
