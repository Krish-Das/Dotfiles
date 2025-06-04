return {
  "mbbill/undotree",
  lazy = true,
  event = "VeryLazy",
  config = function()
    vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
  end
}
