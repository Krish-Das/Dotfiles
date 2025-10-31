---@diagnostic disable: missing-fields
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})
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
      init_selection = "<CR>", -- set to `false` to disable one of the mappings
      node_incremental = "<CR>",
      scope_incremental = "grc",
      node_decremental = "<BS>",
    },
  },
})
