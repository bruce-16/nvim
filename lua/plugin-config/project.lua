local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
    vim.notify("没有找到 project_nvim")
  return
end

-- nvim-tree 支持
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
  detection_methods = { "pattern" },
  -- 设置为手动模式，禁止 project 插件自动修改 root_dir
  manual_mode = true,
  patterns = { ".git", "Makefile", "package.json" },
})

local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end

pcall(telescope.load_extension, "projects")
