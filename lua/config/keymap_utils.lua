---Create keymappings with optional description and mode
---@param keys string The keys to map
---@param func string|function The command or function to execute
---@param desc string|nil Description for the mapping
---@param mode string|string[]|nil Mode(s) for the mapping (default: "n")
---@return nil
local function map(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { desc = desc })
end

return map
