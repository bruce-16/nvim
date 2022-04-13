-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
local runtime_path = vim.split(package.path, ';')
local util = require "lspconfig".util
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts = {
  settings = {
    capabilities = capabilities,
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    settings = {
      css = {
        validate = true
      },
      less = {
        validate = true
      },
      scss = {
        validate = true
      }
    }
  },
  flags = {
    debounce_text_changes = 300,
  },
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- 绑定快捷键
    require('keybindings').mapLSP(buf_set_keymap)
    -- 保存时自动格式化
    -- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
  end,
}

return {
  on_setup = function(server)
    server:setup(opts)
  end,
}
