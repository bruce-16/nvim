vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true
local colorscheme = "tokyonight"
-- vim.g.tokyonight_style = "day"
-- vim.o.background = "light"

-- onedark
-- tokyonight
-- gruvbox
-- nord

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
  return
end

-- require('onedark').setup {
--   style = 'darker'
-- }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
