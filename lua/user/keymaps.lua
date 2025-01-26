local nnoremap = require("user.keymap_utils").nnoremap
local vnoremap = require("user.keymap_utils").vnoremap
local inoremap = require("user.keymap_utils").inoremap
local tnoremap = require("user.keymap_utils").tnoremap
local xnoremap = require("user.keymap_utils").xnoremap
local utils = require "user.utils"
local M = {}

-- █▄█ ▄▀█ █▄░█ █▄▀   ▄▀█ █▄░█ █▀▄   █▀█ ▄▀█ █▀ ▀█▀ █▀▀
-- ░█░ █▀█ █░▀█ █░█   █▀█ █░▀█ █▄▀   █▀▀ █▀█ ▄█ ░█░ ██▄
--
-- Yank and Paste

vnoremap("$", "$h", { desc = "Select upto the end of the line" })

-- greatest remap ever
xnoremap("<leader>p", [["_dP]], { desc = "Paste text and keep original text in register" })

-- second greatest remap ever : asbjornHaland
nnoremap("<leader>Y", [["+Y]], { desc = "Yank current line to system clipboard" })

nnoremap("<leader>y", [["+y]], { desc = "Yank selected text to system clipboard" })
vnoremap("<leader>y", [["+y]], { desc = "Yank selected text to system clipboard" })

--
-- ███╗░░██╗░█████╗░██████╗░███╗░░░███╗░█████╗░██╗░░░░░
-- ████╗░██║██╔══██╗██╔══██╗████╗░████║██╔══██╗██║░░░░░
-- ██╔██╗██║██║░░██║██████╔╝██╔████╔██║███████║██║░░░░░
-- ██║╚████║██║░░██║██╔══██╗██║╚██╔╝██║██╔══██║██║░░░░░
-- ██║░╚███║╚█████╔╝██║░░██║██║░╚═╝░██║██║░░██║███████╗
-- ╚═╝░░╚══╝░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝╚══════╝
--
-- normal mode

-- Disable Space bar since it'll be used as the leader key
nnoremap("<space>", "<nop>")

-- Clear highlights on search when pressing <Esc> in normal mode
nnoremap("<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
nnoremap("<leader>q", function()
  vim.diagnostic.setloclist()
end, { desc = "Open diagnostic [Q]uickfix list" })

-- delete single character without copying into register
nnoremap("x", '"_x')
nnoremap("C", '"_C')
nnoremap("c", '"_c')

-- Select all with '<leader>a'
nnoremap("<leader>a", "ggVG", { desc = "Select all" })

-- Insert line below and above
nnoremap("<leader>o", "o<ESC><UP>", { desc = "Add line under the cursor" })
nnoremap("<leader>O", "O<ESC><DOWN>", { desc = "Add line above the cursor" })

-- Insert line below and above
nnoremap("<leader>bn", "<cmd>bnext<CR>", { desc = "Goto the next buffer" })
nnoremap("<leader>bp", "<cmd>bprevious<CR>", { desc = "Goto the previous buffer" })

-- Move lines up or down
nnoremap("<A-j>", ":m .+1<CR>==", { desc = "Move lines down" })
nnoremap("<A-k>", ":m .-2<CR>==", { desc = "Move lines up" })

nnoremap("J", "mzJ`z", { desc = "Join the line below" })

-- Goto next diagnostic of any severity
nnoremap("]d", function()
  vim.diagnostic.goto_next {}
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto next diagnostic of any severity" })

-- Goto previous diagnostic of any severity
nnoremap("[d", function()
  vim.diagnostic.goto_prev {}
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto next previous of any severity" })

-- Goto next error diagnostic
nnoremap("]e", function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto next error diagnostic" })

-- Goto previous error diagnostic
nnoremap("[e", function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto previous error diagnostic" })

-- Goto next warning diagnostic
nnoremap("]w", function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.WARN }
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto next warning diagnostic" })

-- Goto previous warning diagnostic
nnoremap("[w", function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.WARN }
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto previous warning diagnostic" })

-- Press "leader S" for quick find/replace for the word under the cursor
nnoremap("<leader>R", function()
  local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Replace current word under cursror" })

-- Open the diagnostic under the cursor in a float window
nnoremap("<leader>df", function()
  vim.diagnostic.open_float {
    border = "rounded",
  }
end, { desc = "Open [D]iagnostic in [F]loating window" })

-- Git keymaps --
nnoremap("<leader>gt", ":Telescope git_status<CR>", { desc = "Telescope Git status" })
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle [G]it line [B]lame" })
nnoremap("<leader>gf", function()
  local cmd = {
    "sort",
    "-u",
    "<(git diff --name-only --cached)",
    "<(git diff --name-only)",
    "<(git diff --name-only --diff-filter=U)",
  }
  if not utils.is_git_directory() then
    vim.notify("Current project is not a git directory", vim.log.levels.WARN, { title = "Telescope Git Files", git_command = cmd })
  else
    require("telescope.builtin").git_files()
  end
end, { desc = "Search [G]it [F]iles" })

--
-- ██╗░░░██╗██╗░██████╗██╗░░░██╗░█████╗░██╗░░░░░
-- ██║░░░██║██║██╔════╝██║░░░██║██╔══██╗██║░░░░░
-- ╚██╗░██╔╝██║╚█████╗░██║░░░██║███████║██║░░░░░
-- ░╚████╔╝░██║░╚═══██╗██║░░░██║██╔══██║██║░░░░░
-- ░░╚██╔╝░░██║██████╔╝╚██████╔╝██║░░██║███████╗
-- ░░░╚═╝░░░╚═╝╚═════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝
--
-- visual mode

-- Disable Space bar since it'll be used as the leader key
vnoremap("<space>", "<nop>")

-- Move lines up or down
vnoremap("<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
vnoremap("<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- Yank to system clipboard with <leader>y (only in visual mode)
-- vnoremap("<leader>y", '"+y', { desc = "Yank to selection to system clipboard" })

--
-- ████████╗███████╗██████╗░███╗░░██╗██╗███╗░░░███╗░█████╗░██╗░░░░░
-- ╚══██╔══╝██╔════╝██╔══██╗████╗░██║██║████╗░████║██╔══██╗██║░░░░░
-- ░░░██║░░░█████╗░░██████╔╝██╔██╗██║██║██╔████╔██║███████║██║░░░░░
-- ░░░██║░░░██╔══╝░░██╔══██╗██║╚████║██║██║╚██╔╝██║██╔══██║██║░░░░░
-- ░░░██║░░░███████╗██║░░██║██║░╚███║██║██║░╚═╝░██║██║░░██║███████╗
-- ░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝╚══════╝
--
-- terminal mode

-- Enter normal mode while in a terminal
tnoremap("<esc>", [[<C-\><C-n>]], { desc = "Enter normal mode while in terminal" })

-- Reenable default <space> functionality to prevent input delay
tnoremap("<space>", "<space>")

return M
