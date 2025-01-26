return {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat" },

  config = function()
    -- or use <CR> / <backspace>
    vim.keymap.set({ "n", "x", "o" }, "g>", "<Plug>(leap-forward-to)", {
      desc = "Leap: Forward to",
    })
    vim.keymap.set({ "n", "x", "o" }, "g<", "<Plug>(leap-backward-to)", {
      desc = "Leap: Backward to",
    })
    vim.keymap.set({ "x", "o" }, "x", "<Plug>(leap-forward-till)", {
      desc = "Leap: Forward till",
    })
    vim.keymap.set({ "x", "o" }, "X", "<Plug>(leap-backward-till)", {
      desc = "Leap: Backward till",
    })
    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", {
      desc = "Leap: to non-current buffer",
    })
  end,
}
