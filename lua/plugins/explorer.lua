-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

return {
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      {
        "<leader>e",
        function()
          require("nvim-tree.api").tree.toggle()
        end,
        desc = "Toggle nvim tree",
      },
    },
    opts = {
      hijack_cursor = true,
      disable_netrw = true,
      sort = { sorter = "case_sensitive" },
      view = {
        width = 30,
        side = "left",
        centralize_selection = true,
      },
      renderer = {
        group_empty = true,
        indent_markers = { enable = true },
        add_trailing = true,
        -- root_folder_label = ":t", -- just the root folder
        root_folder_label = ":t:s?^?􁋷  ?", -- root folder with icon
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
          },
        },
      },
      filters = { dotfiles = true },
      git = { enable = true },
      diagnostics = {
        enable = true,
        icons = { hint = "h", info = "i", warning = "W", error = "E" },
      },
    },
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, _)
          return vim.startswith(name, ".") or name == "node_modules"
        end,
      },
    },
    lazy = false,
    keys = {
      {
        "<leader>o",
        function()
          local oil = require("oil")
          if vim.bo.filetype == "oil" then
            oil.close()
          else
            oil.open()
          end
        end,
        desc = "Toggle Oil",
      },
    },
  },
}
