local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
    vim.notify("没有找到 autopairs")
  return
end

autopairs.setup({})
