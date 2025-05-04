local map = require("config.keymap_utils")

-- Disable virtual_text by default
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  signs = true,
  underline = true,
})

-- Toggle virtual text
map("<leader>td", function()
  -- local current_virtual_text = vim.diagnostic.config().virtual_text
  local current_virtual_lines = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = not current_virtual_lines,
    signs = true, -- Always show signs
    underline = true, -- Always show underline
  })
end, "[T]oggle [D]iagnostics")
