local status, cursorline = pcall(require, "nvim-cursorline")
if not status then
    vim.notify("没有找到 cursorline")
  return
end

cursorline.setup({
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
})
