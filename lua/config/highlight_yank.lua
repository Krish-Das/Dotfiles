--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end,
})
