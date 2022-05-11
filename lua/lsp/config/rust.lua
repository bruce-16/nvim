-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rls

local runtime_path = vim.split(package.path, ';')
local util = require "lspconfig".util
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local opts = {
  settings = {
    rust = {
      unstable_features = true,
      build_on_save = false,
      all_features = true,
    },
    cmd = {"rustup", "run", "nightly", "rls"},
    filetypes = {"rust"},
    root_dir = util.root_pattern("Cargo.toml"),
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
    server.setup(opts)
  end,
}
