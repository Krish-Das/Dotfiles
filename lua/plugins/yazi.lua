---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>e",
      "<cmd>Yazi<cr>",
      desc = "Yazi: Open at the current file",
    },
    {
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Yazi: Open in nvim's working directory",
    },
  },
  ---@type YaziConfig
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
    floating_window_scaling_factor = 1,
    yazi_floating_window_border = "none",
    highlight_hovered_buffers_in_same_directory = true,
  },
}
