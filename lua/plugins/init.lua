local map = require("config.keymap_utils")

vim.opt.winborder = "rounded"

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

require("mini.pick").setup()
require("oil").setup()
map("<leader>e", "<cmd>Pick files<CR>")
map("<leader>-", "<cmd>Oil<CR>")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if clent:supports_method('textDocument/completion')then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end
})

-- Set colorscheme
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

map("<leader>rr", ":update<CR>:source<CR>", "Yank current line to system clipboard")

vim.lsp.enable({ "lua_ls" })
map("<leader>fm", ":= vim.lsp.buf.format()<CR>", "Format current buffer")
