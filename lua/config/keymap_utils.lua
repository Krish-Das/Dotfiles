---Create keymappings with optional description and mode
---@param keys string The keys to map
---@param func string|function The command or function to execute
---@param desc string|nil Description for the mapping
---@param mode string|string[]|nil Mode(s) for the mapping (default: "n")
---@return nil
local function map(keys, func, desc, mode)
  mode = mode or "n"
  desc = desc or ""
  local opts = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, keys, func, opts)
end

return map
