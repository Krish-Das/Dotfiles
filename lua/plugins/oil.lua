local nnoremap = require("user.keymap_utils").nnoremap

return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "xiyaowong/transparent.nvim" },
    config = function()
      local oil = require "oil"

      oil.setup {
        columns = { "icon" },
        view_options = {
          show_hidden = false,
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".") or name == "node_modules"
          end,
        },
      }

      nnoremap("<leader>-", function()
        if vim.bo.filetype == "oil" then
          oil.close()
        else
          oil.open()
        end
      end, { desc = "Toggle Oil" })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.opt_local.colorcolumn = ""
        end,
      })

      require("transparent").clear_prefix "Oil"
    end,
  },
}
