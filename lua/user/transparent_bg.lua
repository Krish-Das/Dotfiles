vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
  end,
})
