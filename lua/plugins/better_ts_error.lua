return {
  {
    "OlegGulevskyy/better-ts-errors.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "LspAttach",
    ft = "typescript",
    opts = {
      keymaps = {
        toggle = "<leader>dd", -- default '<leader>dd'
        go_to_definition = "<leader>dx", -- default '<leader>dx'
      },
    },
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    event = "LspAttach",
    ft = "typescript",
    opts = {},
  },
}
