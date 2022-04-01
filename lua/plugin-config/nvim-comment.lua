local status, nvim_comment = pcall(require, "nvim_comment")

if not status then
  vim.notify("没有找到 nvim-comment")
  return
end

-- 快捷键
local list_keys = require('keybindings').nvimCommentList

-- 基本配置
local ops = {
  -- Linters prefer comment and line to have a space in between markers
  marker_padding = true,
  -- should comment out empty or whitespace only lines
  comment_empty = true,
  -- trim empty comment whitespace
  comment_empty_trim_whitespace = true,
  -- Should key mappings be created
  create_mappings = true,
  -- Hook function to call before commenting takes place
  hook = nil
}

for key, value in pairs(list_keys) do
  ops[key] = value;
end

nvim_comment.setup(ops);

