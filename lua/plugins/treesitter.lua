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
      end,
      after = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "diff",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "json",
            "jsonc",
            "typescript",
            "javascript",
            "tsx",
            "css",
            "html",
            "bash",
            "nix",
            "vim",
            "vimdoc",
          },
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
