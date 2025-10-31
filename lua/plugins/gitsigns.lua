---@diagnostic disable: param-type-mismatch
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

local gitsigns = require("gitsigns")

gitsigns.setup({
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or { noremap = true, silent = true }
      opts.buffer = bufnr
      opts.desc = "GSigns: " .. opts.desc
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Navigate to next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Navigate to previous hunk" })

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk [S]tage" })
    map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })

    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "[H]unk [S]tage" })
    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "[H]unk [R]eset" })

    map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage current buffer" })
    map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset current buffer" })
    map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[H]unk [P]review" })
    map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "[H]unk [I]nline preview" })

    map("n", "<leader>hb", function()
      gitsigns.blame_line({ full = true })
    end, { desc = "Git line blame" })

    map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git diff this" })

    map("n", "<leader>hD", function()
      gitsigns.diffthis("~")
    end, { desc = "Git diff this ~" })

    map("n", "<leader>hQ", function()
      gitsigns.setqflist("all")
    end, { desc = "Git quickfix list all" })

    -- Toggles
    map("n", "<leader>tgb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle [G]it line [B]lame" })
    map("n", "<leader>tgw", gitsigns.toggle_word_diff, { desc = "[T]oggle [G]it [W]ord diff" })

    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Git select hunk" })
  end,
})
