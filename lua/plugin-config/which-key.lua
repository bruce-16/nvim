local status, whichKey = pcall(require, "which-key")
if not status then
  vim.notify("没有找到 which-key")
  return
end

local keybindings = require("keybindings")

whichKey.setup {
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
}

whichKey.register(keybindings.whichKeyMapForNormal, {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
})

whichKey.register(keybindings.whichKeyMapForVisual, {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
})
