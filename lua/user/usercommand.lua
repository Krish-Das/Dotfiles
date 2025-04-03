-- List of command pairs (uppercase -> lowercase)
local commands = {
  ["W"] = "w",
  ["Wq"] = "wq",
  ["WQ"] = "wq",
  ["Wa"] = "wa",
  ["WA"] = "wa",
  ["Wqa"] = "wqa",
  ["WQa"] = "wqa",
  ["WQA"] = "wqa",
  ["Bd"] = "bd",
  ["Bda"] = "bda",
}

-- Create command aliases
for uppercase, lowercase in pairs(commands) do
  vim.api.nvim_create_user_command(uppercase, lowercase, {
    desc = string.format("Write command alias for :%s", lowercase),
  })
end
