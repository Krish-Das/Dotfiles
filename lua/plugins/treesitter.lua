local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs", -- Sets main module to use for opts
  opts = {
    ensure_installed = {
      "bash",
      "css",
      "javascript",
      "diff",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "query",
      "vim",
      "vimdoc",
      "json",
      "tsx",
      "typescript",
      "nix",
    },
    auto_install = true,
    sync_install = false,
    highlight = { enable = true },
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
  },
}

return M
