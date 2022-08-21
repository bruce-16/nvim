-- 如果找不到lualine 组件，就不继续执行
local status, lualine = pcall(require, "lualine")
if not status then
    vim.notify("没有找到 lualine")
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = "", modified = "", removed = "" }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local location = {
  "location",
  padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "gruvbox",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = " ", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  extensions = { "nvim-tree", "toggleterm" },
  sections = {
    lualine_a = { { "mode", fmt = function(str) return str:sub(1,1) end } },
    lualine_b = { "branch" },
    lualine_c = { diagnostics, {
      "lsp_progress",
      spinner_symbols = { " ", " ", " ", " ", " ", " " },
    }},
    lualine_x = { "filesize", diff, spaces, "encoding", filetype },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
  -- sections = {
  --   lualine_a = {{ 'mode', fmt = function(str) return str:sub(1,1) end } },
  --   lualine_c = {
  --     {
  --       "lsp_progress",
  --       spinner_symbols = { " ", " ", " ", " ", " ", " " },
  --     },
  --   },
  --   lualine_x = {
  --     "filesize",
  --     {
  --       "fileformat",
  --       -- symbols = {
  --       --   unix = '', -- e712
  --       --   dos = '', -- e70f
  --       --   mac = '', -- e711
  --       -- },
  --       symbols = {
  --         unix = "LF",
  --         dos = "CRLF",
  --         mac = "CR",
  --       },
  --     },
  --     "encoding",
  --     "filetype",
  --   },
  -- },
})
