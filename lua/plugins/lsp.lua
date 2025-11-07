local lze = require("plugin-helper")
lze.add({
  {
    src = "https://github.com/neovim/nvim-lspconfig",
    data = {
      event = "DeferredUIEnter",
      dep_of = { "mason-lspconfig.nvim", "mason-tool-installer.nvim" },
    },
  },
  {
    src = "https://github.com/mason-org/mason.nvim",
    data = {
      event = "DeferredUIEnter",
      dep_of = { "mason-lspconfig.nvim", "mason-tool-installer.nvim" },
      after = function()
        require("mason").setup()
      end,
    },
  },
  {
    src = "https://github.com/mason-org/mason-lspconfig.nvim",
    data = {
      event = "DeferredUIEnter",
      after = function()
        require("mason-lspconfig").setup()
      end,
    },
  },
  {
    src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    data = {
      event = "DeferredUIEnter",
      after = function()
        require("mason-tool-installer").setup({
          ensure_installed = {
            "vim-language-server",
            "lua-language-server",
            "stylua",
            -- "luacheck", -- requires "luarocks" executable in PATH.
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
            -- "alejandra", -- requires "alejandra" executable in PATH.
          },

          -- auto-installs tools on startup
          -- disable it to install manually via :MasonToolsInstall
          run_on_start = false,
          -- start_delay = 5000, -- ms
          -- debounce_hours = 12,

          integrations = {
            ["mason-lspconfig"] = true,
          },
        })

        --
        -- Fix the vim.unidentified vim global
        --
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

        -- Using system-wide nixd (ensure nixd is installed in system PATH)
        vim.lsp.enable("nixd")
        vim.lsp.config("nixd", {
          cmd = { "nixd" },
        })

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
      end,
    },
  },
})
