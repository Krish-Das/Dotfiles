local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/dracula/vim",
    name = "dracula",
    data = {
      event = "VimEnter",
      after = function()
        vim.cmd.colorscheme("dracula")
      end,
    },
  },
})
