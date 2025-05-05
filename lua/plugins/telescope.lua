return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    local telescope = require("telescope")
    local map = require("config.keymap_utils")

    telescope.setup({
      pickers = {},
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    map("<leader>fh", builtin.help_tags, "[F]ind [H]elp")
    map("<leader>fk", builtin.keymaps, "[F]ind [K]eymaps")
    map("<leader>ff", builtin.find_files, "[F]ind [F]iles")
    map("<leader>fs", builtin.builtin, "[F]ind [S]elect Telescope")
    map("<leader>fw", builtin.grep_string, "[F]ind current [W]ord")
    map("<leader>fg", builtin.live_grep, "[F]ind by [G]rep")
    map("<leader>fd", builtin.diagnostics, "[F]ind [D]iagnostics")
    map("<leader>fr", builtin.resume, "[F]ind [R]esume")
    map("<leader>f.", builtin.oldfiles, ".")
    map("<leader><leader>", builtin.buffers, "[ ] Find existing buffers")
    map("<leader>gst", builtin.git_status, "[G]it [S][T]atus")

    map("<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, "[/] Fuzzily search in current buffer")

    map("<leader>f/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, "[F]ind [/] in Open Files")

    -- Shortcut for searching your Neovim configuration files
    map("<leader>fn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, "[F]ind [N]eovim files")
  end,
}
