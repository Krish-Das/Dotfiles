return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.surround").setup()
    require("mini.ai").setup({ n_lines = 500 })
    require("mini.jump").setup({
      delay = {
        -- Delay between jump and highlighting all possible jumps
        highlight = 250,

        -- Delay between jump and automatic stop if idle (no jump is done)
        idle_stop = 500,
      },
    })
  end,
}
