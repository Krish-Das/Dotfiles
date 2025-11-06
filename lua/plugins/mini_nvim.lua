local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/nvim-mini/mini.extra",
    data = {
      dep_of = "mini.pick",
      after = function()
        require("mini.extra").setup()
      end,
    },
  },
  {
    src = "https://github.com/nvim-mini/mini.pick",
    data = {
      -- These are not keymaps!
      -- These are triggers to load the plugin.
      -- Keymaps are set below.
      keys = {
        "<leader>ff",
        "<leader><leader>",
        "<leader>fg",
        "<leader>fh",
        "<leader>fk",
        "<leader>gu",
        "<leader>gs",
      },
      after = function()
        require("mini.pick").setup()
        local map = require("config.keymap_utils")
        map("<leader>ff", "<cmd>Pick files<CR>", "[F]ind [F]iles")
        map("<leader><leader>", "<cmd>Pick buffers<CR>", "[ ] Find existing buffers")
        map("<leader>fg", "<cmd>Pick grep_live<CR>", "[F]ind by [G]rep")
        map("<leader>fh", "<cmd>Pick help<CR>", "[F]ind [H]elp")
        map("<leader>fk", "<cmd>Pick keymaps<CR>", "[F]ind [K]eymaps")

        -- Git unstaged (modified, tracked)
        map("<leader>gu", function()
          MiniPick.start({
            source = {
              items = function()
                return vim.fn.systemlist("git diff --name-only --relative")
              end,
              name = "Git unstaged",
            },
          })
        end, "[G]it [U]nstaged")

        -- Git staged
        map("<leader>gs", function()
          MiniPick.start({
            source = {
              items = function()
                return vim.fn.systemlist("git diff --cached --name-only --relative")
              end,
              name = "Git staged",
            },
          })
        end, "[G]it [S]taged")
      end,
    },
  },
  {
    src = "https://github.com/nvim-mini/mini.surround",
    data = {
      event = "BufReadPost",
      after = function()
        require("mini.surround").setup()
      end,
    },
  },
  {
    src = "https://github.com/nvim-mini/mini.ai",
    data = {
      event = "BufReadPost",
      after = function()
        require("mini.ai").setup()
      end,
    },
  },
})
