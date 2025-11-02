vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

local map = require("config.keymap_utils")
local oil = require("oil")

oil.setup()

-- Keybind to toggle oil
map("<leader>-", function()
  if vim.bo.filetype == "oil" then
    oil.close()
  else
    oil.open()
  end
end, "Toggle Oil")
