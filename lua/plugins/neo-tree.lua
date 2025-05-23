return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    window = {
      position = "right",
    },
    filesystem = {
      filtered_items = {
        hide_by_name = { "node_modules" },
        always_show_by_pattern = { ".env*" },
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = "A",
          modified = "M", -- 
          deleted = "D", -- ⨯
          renamed = "R", -- 󰁕
          -- Status type
          untracked = "?",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "Toggle neotree file explorer",
    },
  },
}
