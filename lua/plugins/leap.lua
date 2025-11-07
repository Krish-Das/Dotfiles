local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/ggandor/leap.nvim",
    data = {
      keys = { "gl", "gL", "x", "X", "gs" },
      after = function()
        local map = require("config.keymap_utils")
        map("gl", "<Plug>(leap-forward-to)", "Leap: Forward to", { "n", "x", "o" })
        map("gL", "<Plug>(leap-backward-to)", "Leap: Backward to", { "n", "x", "o" })
        map("x", "<Plug>(leap-forward-till)", "Leap: Forward till", { "x", "o" })
        map("X", "<Plug>(leap-backward-till)", "Leap: Backward till", { "x", "o" })
        map("gs", "<Plug>(leap-from-window)", "Leap: to non-current buffer", { "n", "x", "o" })
      end,
    },
  },
})
