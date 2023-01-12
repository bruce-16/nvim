local status_ok, neogen = pcall(require, "neogen")
if not status_ok then
    vim.notify("没有找到 neogen")
  return
end

neogen.setup {
    enabled = true,             --if you want to disable Neogen
}

