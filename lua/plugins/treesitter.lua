---@diagnostic disable: missing-fields
local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    data = {
      event = { "VimEnter" },
      before = function()
        vim.o.foldmethod = "expr"
        vim.o.foldexpr = "nvim_treesitter#foldexpr()"
        vim.o.foldcolumn = "0"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
      end,
      after = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "lua" },
          highlight = { enable = true },
          auto_install = false,
          sync_install = false,
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "<CR>",
              node_incremental = "<CR>",
              scope_incremental = "grc",
              node_decremental = "<BS>",
            },
          },
        })
      end,
    },
  },
})
