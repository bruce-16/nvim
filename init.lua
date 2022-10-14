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
require("plugin-config.nvim-treesitter")
-- require("plugin-config.lsp_signature")
require("plugin-config.autopairs")
require("plugin-config.hop")
require("plugin-config.lspsaga")
require("plugin-config.which-key")
require("plugin-config.toggleterm")
require("plugin-config.comment")
require("plugin-config.illuminate")
require("plugin-config.impatient")
require("plugin-config.nvim-surround")

-- autocommands
require('autocommands')

-- custom-func
require("custom-func.work")

-- gitsigns 配置
require("plugin-config.gitsigns")

-- lsp
require("lsp.setup")
-- require('lsp.null-ls')

