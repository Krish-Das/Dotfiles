return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  opts = {
    fzf_colors = true,
    defaults = { formatter = "path.dirname_first" },
  },
  keys = {
    { "<leader>f<space>", "<CMD>FzfLua<CR>", desc = "Open FZF picker" },
    { "<leader>ff", "<CMD>FzfLua files<CR>", desc = "Find Files" },
    { "<leader><space>", "<CMD>FzfLua buffers<CR>", desc = "Find in Buffers" },
    { "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
    { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Find by Grep" },
    { "<leader>uC", "<cmd>FzfLua colorschemes<cr>", desc = "Find Colorschemes" },
    { "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Search Help Pages" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Find Keymaps" },
    { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "LSP Document Symbols" },
    { "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "LSP Workspace Symbols" },
    { "<leader>gg", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
  },
}
