local map = require("config.keymap_utils")

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("<Esc>", "<cmd>nohlsearch<CR>", "Clear highlights on search")
map("<leader>a", "ggVG", "Select all")

map("$", "$h", "Select upto the end of the line", "v")

-- Yanking and pasting text
map("<leader>Y", [["+Y]], "Yank current line to system clipboard")
map("<leader>y", [["+y]], "Yank selected text to system clipboard")
map("<leader>y", [["+y]], "Yank selected text to system clipboard", "v")
map("<leader>p", [["_dP]], "Paste text and keep original text in register", "x")

-- delete single character without copying into register
map("x", '"_x')
map("C", '"_C')
map("c", '"_c')

-- Switch buffer
map("<leader>bn", "<cmd>bnext<CR>", "Goto the next buffer")
map("<leader>bp", "<cmd>bprevious<CR>", "Goto the previous buffer")

-- Move lines up or down
map("<A-j>", ":m .+1<CR>==", "Move lines down")
map("<A-k>", ":m .-2<CR>==", "Move lines up")
map("<A-j>", ":m '>+1<CR>gv=gv", "Move lines down", "v")
map("<A-k>", ":m '<-2<CR>gv=gv", "Move lines up", "v")

map("<C-s>", ":w<CR>", "Write current buffer to the file")

-- Join lines below and move cursor where it was
-- map("J", "mzJ`z", "Join the line below")

-- Diagnostic keymaps
map("<leader>q", function()
  vim.diagnostic.setloclist()
end, "Open diagnostic [Q]uickfix list")

-- Open the diagnostic under the cursor in a float window
map("<leader>df", function()
  vim.diagnostic.open_float({
    border = "rounded",
  })
end, "Open [D]iagnostic in [F]loating window")
