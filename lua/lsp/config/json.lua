-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
local util = require "lspconfig".util

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts = {
  settings = {
    capabilities = capabilities,
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
      provideFormatter = true
    },
    root_dir = util.find_git_ancestor,
    single_file_support = true,
  },
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(_, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    -- client.resolved_capabilities.document_formatting = false
    -- client.resolved_capabilities.document_range_formatting = false

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
