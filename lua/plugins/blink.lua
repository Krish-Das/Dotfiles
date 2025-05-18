--
-- Completion engine
--
return {
  "saghen/blink.cmp",
  event = "VimEnter",
  version = "1.*",
  dependencies = {
    require("plugins.snippets"),
  },

  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = { preset = "default" },
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },
    completion = {
      ghost_text = { enabled = false },
      menu = { auto_show = false, winblend = 1 },
      documentation = { auto_show = false, window = { winblend = 1 } },
    },
    signature = { enabled = true, window = { winblend = 1 } },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "lazydev", "buffer" },
      providers = {
        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
    fuzzy = {
      implementation = "lua",
      sorts = { "exact", "score", "sort_text" },
    },
  },
}
