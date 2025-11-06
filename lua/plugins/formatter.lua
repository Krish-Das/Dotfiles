local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/stevearc/conform.nvim",
    data = {
      keys = { "<leader>fm" },
      event = "BufWritePre",
      after = function()
        require("conform").setup({
          notify_on_error = false,
          formatters_by_ft = { lua = { "stylua" } },
          format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
        })
        local map = require("config.keymap_utils")
        local has_conform, conform = pcall(require, "conform")
        map("<leader>fm", function()
          if has_conform then
            conform.format({ async = true, lsp_format = "fallback" })
          else
            vim.lsp.buf.format()
          end
        end, "[F]or[M]at current buffer")
      end,
    },
  },
})
