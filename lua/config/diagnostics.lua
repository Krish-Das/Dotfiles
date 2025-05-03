local map = require("config.keymap_utils")

-- Disable virtual_text by default
vim.diagnostic.config({
  virtual_text = false,
  signs = true, -- Always show signs
  underline = true, -- Always show underline
})

-- Toggle virtual text
map("<leader>td", function()
  local current_virtual_text = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = not current_virtual_text,
    signs = true, -- Always show signs
    underline = true, -- Always show underline
  })
end, "[T]oggle [D]iagnostics")
