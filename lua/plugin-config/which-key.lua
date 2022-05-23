local status, whichKey = pcall(require, "which-key")
if not status then
  vim.notify("没有找到 which-key")
  return
end

local keybindings = require("keybindings")

whichKey.register(keybindings.whichKeyMap, { prefix = "<leader>" })
