return {
  {
    "kevinhwang91/nvim-ufo",
    event = "BufEnter",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      --- @diagnostic disable: unused-local
      require("ufo").setup {
        provider_selector = function(_bufnr, _filetype, _buftype)
          return { "treesitter", "indent" }
        end,
      }
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.o.fillchars = [[eob: ,fold: ,foldopen: ,foldsep: ,foldclose: ]]

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "UFO: Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "UFO: Close all folds" })
    end,
  },
}
