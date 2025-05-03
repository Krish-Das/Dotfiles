local map = require("config.keymap_utils")

return {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat" },

  config = function()
    map("g>", "<Plug>(leap-forward-to)", "Leap: Forward to", { "n", "x", "o" })
    map("g<", "<Plug>(leap-backward-to)", "Leap: Backward to", { "n", "x", "o" })
    map("x", "<Plug>(leap-forward-till)", "Leap: Forward till", { "x", "o" })
    map("X", "<Plug>(leap-backward-till)", "Leap: Backward till", { "x", "o" })
    map("gs", "<Plug>(leap-from-window)", "Leap: to non-current buffer", { "n", "x", "o" })
  end,
}
