local map = require("config.keymap_utils")

vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("mini.pick").setup()
require("oil").setup()
require("mason").setup()
require("nvim-treesitter.configs").setup({
  ensure_installed = { "typescript", "javascript" },
  auto_install = false,
  ignore_install = {},
  modules = {},
  sync_install = false,
  highlight = { enable = true }
})

map("<leader>e", "<cmd>Pick files<CR>")
map("<leader>-", "<cmd>Oil<CR>")

-- Set colorscheme
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

map("<leader>rr", ":update<CR>:source<CR>", "Yank current line to system clipboard")

vim.lsp.enable({ "lua_ls", "biome" })
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
})

vim.lsp.config("biome", {})
map("<leader>fm", function() vim.lsp.buf.format() end)
