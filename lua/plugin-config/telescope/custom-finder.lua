local M = {}

local _, builtin = pcall(require, "telescope.builtin")
-- local _, finders = pcall(require, "telescope.finders")
-- local _, pickers = pcall(require, "telescope.pickers")
-- local _, sorters = pcall(require, "telescope.sorters")
-- local _, themes = pcall(require, "telescope.themes")
-- local _, actions = pcall(require, "telescope.actions")
-- local _, previewers = pcall(require, "telescope.previewers")
-- local _, make_entry = pcall(require, "telescope.make_entry")

-- local utils = require "lvim.utils"
--
-- Smartly opens either git_files or find_files, depending on whether the working directory is
-- contained in a Git repo.
function M.find_project_files()
  local ok = pcall(builtin.git_files)

  if not ok then
    builtin.find_files()
  end
end

-- 大小写、单词
function M.live_grep_strict()
  local vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--line-number",
    "--column",
    "--case-sensitive",
    "-w",
  }
  builtin.live_grep({ vimgrep_arguments = vimgrep_arguments })
end

-- 搜索单词
function M.live_grep_word()
  local vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--line-number",
    "--column",
    "--smart-case",
    "-w",
  }
  builtin.live_grep({ vimgrep_arguments = vimgrep_arguments })
end

-- 大小写敏感
function M.live_grep_case_sensitive()
  local vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--line-number",
    "--column",
    "--case-sensitive",
    '--trim',
  }
  builtin.live_grep({ vimgrep_arguments = vimgrep_arguments })
end

return M

