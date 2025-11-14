local event = { "BufReadPost", "BufNewFile" }
return {
  -- Mini.nvim
  { "nvim-mini/mini.surround", opts = {}, event = event },
  { "nvim-mini/mini.ai", opts = {}, event = event },

  -- Autotag
  {
    "windwp/nvim-ts-autotag",
    ft = { "typescriptreact", "javascriptreact" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false, -- Auto close on trailing </
      },
      per_filetype = {
        ["html"] = { enable_close = false },
      },
    },
  },

  -- Leap jump
  {
    "ggandor/leap.nvim",
    keys = { "<A-l>", "<A-h>", "x", "X", "gs" },
    config = function()
      local map = require("config.keymap_utils")
      map("<A-l>", "<Plug>(leap-forward-to)", "Leap: Forward to", { "n", "x", "o" })
      map("<A-h>", "<Plug>(leap-backward-to)", "Leap: Backward to", { "n", "x", "o" })
      map("x", "<Plug>(leap-forward-till)", "Leap: Forward till", { "x", "o" })
      map("X", "<Plug>(leap-backward-till)", "Leap: Backward till", { "x", "o" })
      map("gs", "<Plug>(leap-from-window)", "Leap: to non-current buffer", { "n", "x", "o" })
    end,
  },

  -- Fold plugin
  {
    "chrisgrieser/nvim-origami",
    event = event,
    opts = {
      foldtext = {
        lineCount = { template = " %d" },
      },
      autoFold = { enabled = false },
    },
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },

  -- Startup time
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      -- Configuration for plugins that don't force you to call a `setup` function
      -- for initialization should typically go in a `before`
      --- or `beforeAll` function.
      vim.g.startuptime_tries = 10
    end,
  },
}
