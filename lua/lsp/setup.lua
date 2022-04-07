local lsp_installer = require("nvim-lsp-installer")

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
}
-- 自动安装 Language Servers
for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

lsp_installer.on_server_ready(function(server)
  local config = servers[server.name]
  if config == nil then
    return
  end
  if config.on_setup then
    config.on_setup(server)
  else
    server:setup({})
  end
end)

-- https://github.com/neovim/nvim-lspconfig
-- 更多样式定制，参见：https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization

-- 诊断样式定制
vim.diagnostic.config({
  -- 诊断的虚拟文本
  virtual_text = {
    -- 显示的前缀，可选项：'●', '▎', 'x'
    -- 默认是一个小方块，不是很好看，所以这里改了
    prefix = "●",
    -- 是否总是显示前缀？是的
    source = "always"
  },
  float = {
    -- 是否显示诊断来源？是的
    source = "always"
  },
  -- 在插入模式下是否显示诊断？不要
  update_in_insert = false
})

