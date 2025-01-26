local nnoremap = require("user.keymap_utils").nnoremap

-- Define custom diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "▲", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "ℹ", texthl = "DiagnosticSignInfo" })
--  ▲  ℹ
--    ℹ

-- Disable virtual_text by default
vim.diagnostic.config {
  virtual_text = false,
  signs = true, -- Always show signs
  underline = true, -- Always show underline
}

-- Keybinding to toggle virtual_text
nnoremap("<leader>td", function()
  local current_virtual_text = vim.diagnostic.config().virtual_text
  vim.diagnostic.config {
    virtual_text = not current_virtual_text,
    signs = true, -- Always show signs
    underline = true, -- Always show underline
  }
end, { desc = "[T]oggle [D]iagnostics" })
