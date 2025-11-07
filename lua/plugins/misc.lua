local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/j-hui/fidget.nvim",
    data = {
      event = "VimEnter",
      after = function()
        require("fidget").setup({})
      end,
    },
  },
})
