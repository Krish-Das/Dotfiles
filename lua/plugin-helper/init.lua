-- lua/plugins/init.lua
local M = {}
local should_confirm = true

-- ensure lze is installed/registered early
function M.setup()
  vim.pack.add({ "https://github.com/BirdeeHub/lze" }, { load = function() end, confirm = should_confirm })
  vim.cmd.packadd("lze")
  M.lze = require("lze")
end

-- common load callback used for all plugin specs
local function common_load(p)
  local spec = p.spec.data or {}
  spec.name = p.spec.name
  -- attach runtime-only functions here if needed
  M.lze.load(spec)
end

-- public add function: accepts a list of specs (same shape you already use)
function M.add(specs)
  -- call setup once if not done
  if not M.lze then
    M.setup()
  end
  vim.pack.add(specs, { load = common_load, confirm = should_confirm })
end

return M
