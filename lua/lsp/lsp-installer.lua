local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

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

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for name, server in pairs(servers) do
  opts = {
    on_attach = require("lsp.handlers").on_attach,
    capabilities = require("lsp.handlers").capabilities,
  }

  if server ~= nil and type(server) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    server.on_setup(lspconfig[name], opts)
  else
    -- 使用默认参数
    lspconfig[name].setup(opts)
  end
end
