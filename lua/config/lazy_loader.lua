-- lazy_loader.lua
local M = {}

--- Lazy load a plugin with optional event-based loading
-- @param plugin_url string: GitHub URL or module name
-- @param opts table|nil: { events = {...}, setup = function(mod) or table }
-- @return table|nil: The loaded module or nil if failed
function M.lazy_load(plugin_url, opts)
  opts = opts or {}

  if not plugin_url or type(plugin_url) ~= "string" then
    vim.notify("lazy_load: plugin_url must be a string", vim.log.levels.WARN)
    return nil
  end

  -- Extract module name from URL or use as-is
  local module_name = plugin_url:match("([^/]+)$") or plugin_url

  -- Add plugin to pack if it's a URL
  if plugin_url:match("^https?://") then
    local success, err = pcall(vim.pack.add, { plugin_url })
    if not success then
      vim.notify("Failed to add plugin: " .. plugin_url .. ". Error: " .. tostring(err), vim.log.levels.ERROR)
      return nil
    end
  end

  local function load_and_setup()
    -- Check if already loaded
    if package.loaded[module_name] then
      return package.loaded[module_name]
    end

    local success, module = pcall(require, module_name)
    if not success then
      vim.notify("Failed to load module: " .. module_name .. ". Error: " .. tostring(module), vim.log.levels.ERROR)
      return nil
    end

    -- Handle setup
    if opts.setup then
      local setup_fn = type(opts.setup) == "function" and opts.setup
        or function(m)
          m.setup(opts.setup)
        end
      local setup_success, setup_err = pcall(setup_fn, module)
      if not setup_success then
        vim.notify("Setup failed for: " .. module_name .. ". Error: " .. tostring(setup_err), vim.log.levels.ERROR)
      end
    end

    return module
  end

  -- Lazy load on events or load immediately
  if opts.events and #opts.events > 0 then
    local loaded = false
    vim.api.nvim_create_autocmd(opts.events, {
      callback = function()
        if not loaded then
          loaded = true
          load_and_setup()
          return true -- Remove autocmd
        end
      end,
    })
    -- Return a proxy or nil for lazy loading
    return nil
  else
    return load_and_setup()
  end
end

return M
