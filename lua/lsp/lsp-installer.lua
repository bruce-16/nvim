-- :h mason-default-settings
-- ~/.local/share/nvim/mason
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
require("mason-lspconfig").setup({
  ensure_installed = {
    "sumneko_lua",
    "tsserver",
    "tailwindcss",
    "bashls",
    "cssls",
    "html",
    "jsonls",
    "rust_analyzer",
    "cspell",
  },
})

local lspconfig = require("lspconfig")
-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
local servers = {
  sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
  tsserver = require("lsp.config.ts"), -- lua/lsp/config/ts.lua
  rust_analyzer = require "lsp.config.rust", -- lua/lsp/config/rust
  jsonls = require "lsp.config.json", -- lua/lsp/config/json
  html = require "lsp.config.html", -- lua/lsp/config/html
  cssls = require "lsp.config.css", -- lua/lsp/config/css
  -- cssmodules_ls = require "lsp.config.cssmodule", -- lua/lsp/config/cssmodule
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end
