-- lazy_loader_example.lua
-- Example usage of the lazy loading function

local lazy_loader = require("config.lazy_loader")

-- Example 1: Basic lazy loading
local telescope = lazy_loader.lazy_load("telescope")

-- Example 2: Lazy loading with setup function
local nvimtree = lazy_loader.lazy_load("nvim-tree", {
  setup = function(module)
    module.setup({
      -- your nvim-tree configuration here
    })
  end,
})

-- Example 3: Storing in local variable for later use
local function load_lsp_modules()
  local lspconfig = lazy_loader.lazy_load("lspconfig")
  if lspconfig then
    -- Use lspconfig here
    print("lspconfig loaded successfully")
  end
end

return {
  load_lsp_modules = load_lsp_modules,
}
