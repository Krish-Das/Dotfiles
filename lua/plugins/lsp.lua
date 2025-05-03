-- LSP Plugins
local LSPPlugins = {
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  -- used for completion, annotations and signatures of Neovim apis
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}

-- Main LSP Configuration
local LSP = {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    -- Setting up Mason as it must be loaded before its dependents
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "󰄠",
            package_uninstalled = "✗",
          },
        },
      },
    },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    "saghen/blink.cmp",
  },
  config = function()
    -- setup the lsp-bindings
    -- dependencies: Telescope
    require("config.lsp-bindings")

    -- Diagnostic Config
    -- See :help vim.diagnostic.Opts
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = "▲ ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      } or {},
      virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local servers = {
      lua_ls = {
        settings = {
          Lua = { completion = { callSnippet = "Replace" } },
        },
      },
      cssls = {},
      eslint = {},
      html = {},
      jsonls = {},
      tailwindcss = {},
      ts_ls = {},
      emmet_ls = {},
      nil_ls = {},
    }

    -- Ensure the servers and tools above are installed
    -- Add other tools here that for Mason to install
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua",
      "shellcheck",
      "shfmt",
      "bashls",
      "prettierd",
      "eslint_d",
      "alejandra",
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
      ensure_installed = {}, -- explicitly set to an empty table (gets populated via mason-tool-installer)
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}

return { LSPPlugins, LSP }
