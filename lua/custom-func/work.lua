-- map('模式', '按键', '映射lsp_finder为', 'options')
local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

local M = {}

-- 在当前目录下打开 3001 服务, 并且打开终端
local function bear_start_sheet(isSheet)
  local termExec = require'toggleterm'.exec
  local cmd ="dum start"

  if (isSheet)
  then
    cmd = cmd..":sheet"
  end

  -- vim.pretty_print({ cmd = cmd })
  termExec(cmd, 1)
end

-- 控制 tmux 垂直切分当前 window
local function tmux_vsplit_window(cmd)
  local str = string.format("tmux split-window -h %s", cmd)
  os.execute(str)
end

-- 控制 tmux 水平直切分当前 window
local function tmux_hsplit_window(cmd)
  local str = string.format("tmux split-window -f %s", cmd)
  os.execute(str)
end

-- which key setting
local whichKeyMap = require"keybindings".whichKeyMapForNormal

if (whichKeyMap["z"]["s"] == nil)
then
  whichKeyMap["z"]["s"] = { name = "start server" }
end

whichKeyMap["z"]["s"]["s"] = {
  function ()
    bear_start_sheet(true)
  end,
  "Start Web Sheet"
}

whichKeyMap["z"]["s"]["a"] = {
  function ()
    bear_start_sheet(false)
  end,
  "Start Web 3001"
}


M.bear_start_sheet = bear_start_sheet
M.tmux_vsplit_window = tmux_vsplit_window
M.tmux_hsplit_window = tmux_hsplit_window

return M
