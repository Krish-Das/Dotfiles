local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/nvim-tree/nvim-tree.lua",
    data = {
      keys = "<leader>e",
      before = function()
        -- optionally enable 24-bit colour
        vim.opt.termguicolors = true
      end,
      after = function()
        require("nvim-tree").setup({
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
        })

        -- enable keymap
        local map = require("config.keymap_utils")
        map("<leader>e", function()
          require("nvim-tree.api").tree.toggle()
        end, "Toggle nvim tree")
      end,
    },
  },
})
