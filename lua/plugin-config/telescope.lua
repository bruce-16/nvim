local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- 窗口内快捷键
    mappings = require("keybindings").telescopeList,
    -- 搜索面板结果太长会自动换行
    wrap_results = 1,
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    git_files = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
    },
    marks = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    grep_string = {
      theme = "ivy",
    },
    lsp_references = {
      theme = "ivy",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    lazygit = {
      lazygit_floating_window_winblend = 0, -- transparency of floating window
      lazygit_floating_window_scaling_factor = 0.9, -- scaling factor for floating window
      lazygit_floating_window_corner_chars = { '╭', '╮', '╰', '╯' }, -- customize lazygit popup window corner characters
      lazygit_floating_window_use_plenary = 0, -- use plenary.nvim to manage floating window if available
      lazygit_use_neovim_remote = 0, -- fallback to 0 if neovim-remote is not installed
    }
  },
})

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "env")
-- pcall(telescope.load_extension, "lazygit")

