vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("vertical_help", { clear = true }),
  pattern = "*.txt",
  callback = function()
    if vim.bo.buftype == "help" then
      vim.cmd.wincmd("L")
      vim.cmd.wincmd("=")
    end
  end,
})
