vim.pack.add({
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.extra",
})
require("mini.pick").setup()
require("mini.surround").setup()
require("mini.ai").setup({ n_lines = 500 })
require("mini.extra").setup()

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
map("<leader>gd", function()
  MiniPick.start({
    source = {
      items = function()
        return vim.fn.systemlist("git diff --cached --name-only --relative")
      end,
      name = "Git staged",
    },
  })
end, "[G]it stage[D]")
