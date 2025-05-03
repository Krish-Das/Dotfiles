return {
  {
    "kevinhwang91/nvim-ufo",
    event = "BufEnter",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      local map = require("config.keymap_utils")
      local opt = vim.o

      --- @diagnostic disable: unused-local
      require("ufo").setup({
        provider_selector = function(_bufnr, _filetype, _buftype)
          return { "treesitter", "indent" }
        end,
      })
      opt.foldcolumn = "0"
      opt.foldlevel = 99
      opt.foldlevelstart = 99
      opt.foldenable = true

      opt.fillchars = [[eob: ,fold: ,foldopen: ,foldsep: ,foldclose: ]]

      map("zR", require("ufo").openAllFolds, "UFO: Open all folds")
      map("zM", require("ufo").closeAllFolds, "UFO: Close all folds")
    end,
  },
}
