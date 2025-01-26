-- █▀█ █░░ █░█ █▀▀ █ █▄░█ █▀
-- █▀▀ █▄▄ █▄█ █▄█ █ █░▀█ ▄█

local lazydev_nvim = {
  -- used for completion, annotations and signatures of Neovim apis
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
}
local luvit_meta = { "Bilal2453/luvit-meta", lazy = true }

-- █▀▄▀█ ▄▀█ █ █▄░█   █▀▀ █▀█ █▄░█ █▀▀
-- █░▀░█ █▀█ █ █░▀█   █▄▄ █▄█ █░▀█ █▀░

local nvim_lspconfig = {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", opts = {} },

    -- Allows extra capabilities provided by nvim-cmp
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  To jump back, press <C-t>.
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor.
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

        -- Fuzzy find all the symbols in your current document.
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace.
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- Rename the variable under your cursor.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

        -- This is not Goto Definition, this is Goto Declaration.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        --
        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        --
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    -- █▀▀ ▄▀█ █▀█ ▄▀█ █▄▄ █ █░░ █ ▀█▀ █ █▀▀ █▀
    -- █▄▄ █▀█ █▀▀ █▀█ █▄█ █ █▄▄ █ ░█░ █ ██▄ ▄█
    --
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ █▀
    -- ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄█
    --
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            -- ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      cssls = {},
      eslint = {},
      html = {},
      jsonls = {},
      tailwindcss = {},
      ts_ls = {},
      emmet_ls = {},
    }

    -- █▀▄▀█ ▄▀█ █▀ █▀█ █▄░█
    -- █░▀░█ █▀█ ▄█ █▄█ █░▀█
    --
    --  You can press `g?` for help in the :Mason menu.
    --
    require("mason").setup {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "󰄠",
          package_uninstalled = "✗",
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua",
      "lua_ls",
      "shellcheck",
      "shfmt",
      "bashls",
      "prettierd",
      "eslint_d",
    })

    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    require("mason-lspconfig").setup {
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
    }
  end,
}

-- ▄▀█ █░█ ▀█▀ █▀█   █▀▀ █▀█ █▀█ █▀▄▀█ ▄▀█ ▀█▀
-- █▀█ █▄█ ░█░ █▄█   █▀░ █▄█ █▀▄ █░▀░█ █▀█ ░█░
--
local autoformat = {
  "stevearc/conform.nvim",
  --
  -- TODO: Add event when new file is created
  -- get if from josean's youtube video
  --
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format { async = true, lsp_format = "fallback" }
      end,
      mode = "",
      desc = "[F]or[M]at buffer",
    },
  },
  opts = {
    notify_on_error = false,
    -- format_on_save = function(bufnr)
    --   -- Disable "format_on_save lsp_fallback" for languages that don't
    --   -- have a well standardized coding style. You can add additional
    --   -- languages here or re-enable it for the disabled ones.
    --   local disable_filetypes = { c = true, cpp = true }
    --   local lsp_format_opt
    --   if disable_filetypes[vim.bo[bufnr].filetype] then
    --     lsp_format_opt = "never"
    --   else
    --     lsp_format_opt = "fallback"
    --   end
    --   return {
    --     timeout_ms = 500,
    --     lsp_format = lsp_format_opt,
    --   }
    -- end,
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      toml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}

-- ▄▀█ █░█ ▀█▀ █▀█   █▀▀ █▀█ █▀▄▀█ █▀█ █░░ █▀▀ ▀█▀ █ █▀█ █▄░█
-- █▀█ █▄█ ░█░ █▄█   █▄▄ █▄█ █░▀░█ █▀▀ █▄▄ ██▄ ░█░ █ █▄█ █░▀█
--
local autocompletion = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      build = (function()
        if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
  },
  config = function()
    -- See `:help cmp`
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = "menu,menuone,noinsert" },

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ["<C-p>"] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window [b]ack / [f]orward
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ["<C-y>"] = cmp.mapping.confirm { select = true },

        -- Manually trigger a completion from nvim-cmp.
        ["<C-Space>"] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },
      sources = {
        {
          name = "lazydev",
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      },
    }
  end,
}

--
-- ▄▀█ █░█ ▀█▀ █▀█ ▀█▀ ▄▀█ █▀▀
-- █▀█ █▄█ ░█░ █▄█ ░█░ █▀█ █▄█
--
local ts_autotag = {
  "windwp/nvim-ts-autotag",
  ft = {
    "javascriptreact",
    "typescriptreact",
  },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}

-- █▀█ █▀▀ ▀█▀ █░█ █▀█ █▄░█
-- █▀▄ ██▄ ░█░ █▄█ █▀▄ █░▀█
--
return { lazydev_nvim, luvit_meta, nvim_lspconfig, autoformat, autocompletion, ts_autotag }
