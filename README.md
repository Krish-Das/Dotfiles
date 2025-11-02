### Using `Pick()` with `mini.pick`

1. Open the picker.
2. Mark items with `<C-x>`. Use `<C-a>` to toggle selection for all visible matches.
3. Press `<M-CR>` to send the marked items to the quickfix list.
   _(On Linux, the Meta key usually corresponds to the Alt key.)_
4. Run `:cdo` to execute a command on each quickfix entry.
5. When done, use `:cfdo update` to save all modified files.

### NvimTree Toggle/Focus Mapping

Currently, `<leader>e` runs `api.tree.toggle()` to open or close the tree.

To bring back the behavior where `<leader>e` focuses the tree if it's not active, and closes it if it is, use this mapping instead:

```lua
map("<leader>e", function()
  local api = require("nvim-tree.api")
  if api.tree.is_tree_buf() then
    api.tree.toggle()
  else
    api.tree.focus()
  end
end, "Toggle/Focus nvim tree")
```
