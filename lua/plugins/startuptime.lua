local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/dstein64/vim-startuptime",
    data = {
      cmd = "StartupTime",
      before = function()
        -- Configuration for plugins that don't force you to call a `setup` function
        -- for initialization should typically go in a `before`
        --- or `beforeAll` function.
        vim.g.startuptime_tries = 10
      end,
    },
  },
})
