local lsp = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    { "mason-org/mason-lspconfig.nvim", opts = {} },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = {
        ensure_installed = {
          "vim-language-server",
          "lua-language-server",
          "stylua",
          "typescript-language-server",
          "css-lsp",
          "html-lsp",
          "json-lsp",
          "tailwindcss-language-server",
          "biome",
          "prettierd",
          "shellcheck",
          "shfmt",
          "bash-language-server",
          -- "luacheck", -- requires "luarocks" executable in PATH.
          -- "alejandra", -- requires "alejandra" executable in PATH.
        },
        integrations = { ["mason-lspconfig"] = true },

        -- auto-installs tools on startup
        -- disable it to install manually via :MasonToolsInstall
        run_on_start = false,
        -- start_delay = 5000, -- ms
        -- debounce_hours = 12,
      },
    },
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    -- Fix unidentified vim global
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim", "require" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          telemetry = { enable = false },
        },
      },
    })

    -- Disable the warning with tailwind directives
    vim.lsp.config("cssls", {
      settings = {
        css = { lint = { unknownAtRules = "ignore" } },
      },
    })

    -- Use nixd binary from system PATH
    -- nixd needs to be installed in system PATH
    vim.lsp.config("nixd", { cmd = { "nixd" } })
    vim.lsp.enable("nixd")

    --
    -- Automatically trigger lsp autocompletion
    --
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client ~= nil and client:supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
      end,
    })
    vim.cmd("set completeopt+=noselect")

    --
    -- Notify user that mason is starting to install
    --
    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsStartingInstall",
      callback = function()
        vim.schedule(function()
          vim.notify("mason-tool-installer is starting", vim.log.levels.INFO, { title = "mason-tool-installer" })
        end)
      end,
    })
  end,
}

local formatter = {}

return { lsp, formatter }
