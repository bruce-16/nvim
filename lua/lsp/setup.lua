local lsp_installer = require("nvim-lsp-installer")

lsp_installer.setup({
  -- 自动安装 Language Servers
  automatic_installation = true,
})

local lspconfig = require("lspconfig")

-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
  tsserver = require("lsp.config.ts"), -- lua/lsp/config/ts.lua
  rls = require "lsp.config.rust", -- lua/lsp/config/ts
  rust_analyzer = require "lsp.config.rust_analyzer", -- lua/lsp/config/rust_analyzer
  jsonls = require "lsp.config.json", -- lua/lsp/config/json
  html = require "lsp.config.html", -- lua/lsp/config/html
  cssls = require "lsp.config.css", -- lua/lsp/config/css
  cssmodules_ls = require "lsp.config.cssmodule", -- lua/lsp/config/cssmodule
}
-- 自动安装 Language Servers
for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end
