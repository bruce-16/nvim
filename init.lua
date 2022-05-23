-- 基础设置
require('basic')
-- 键盘映射
require("keybindings")
-- Packer 插件管理
require("plugins")
-- 主题设置
require("colorscheme")
-- 插件配置
require("plugin-config.nvim-tree")
require("plugin-config.bufferline")
require("plugin-config.lualine")
require("plugin-config.telescope")
require("plugin-config.dashboard")
require("plugin-config.project")
require("plugin-config.nvim-treesitter")
require("plugin-config.lsp_signature")
require("plugin-config.diffview")
require("plugin-config.autopairs")
require("plugin-config.markdown-preview")
require("plugin-config.marks")
require("plugin-config.cursorline")
require("plugin-config.hop")
require("plugin-config.lspsaga")
require("plugin-config.which-key")

-- coding 配置
require("plugin-config.nvim-comment")
-- gitsigns 配置
require("plugin-config.gitsigns")

-- lsp
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")
require("lsp.null-ls")

