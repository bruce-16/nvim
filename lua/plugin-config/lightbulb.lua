-- https://github.com/kosayoda/nvim-lightbulb
local status, lightbulb = pcall(require, "nvim-lightbulb")
if not status then
    vim.notify("没有找到 lightbulb")
  return
end

lightbulb.setup {

}

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
