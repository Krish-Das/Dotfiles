local map = require("config.keymap_utils")

vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
  notify_on_error = false,
  formatters_by_ft = {
    lua = { "stylua" },
    -- nix = { "alejandra" },
    yaml = { "biome" },
    toml = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },
    css = { "biome" },
    typescript = { "biome" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescriptreact = { "biome" },
    html = { "prettierd", "prettier", stop_after_first = true }, -- Biome is not working on this
    markdown = { "prettierd", "prettier", stop_after_first = true }, -- No support for Biome
  },
})

--
-- Format buffer: use conform.nvim if available, otherwise fallback to native LSP formatting
-- Check is cached after first call, so performance impact is negligible
--
local has_conform, conform = pcall(require, "conform")
map("<leader>fm", function()
  if has_conform then
    conform.format({ async = true, lsp_format = "fallback" })
  else
    vim.lsp.buf.format()
  end
end, "[F]or[M]at current buffer")
