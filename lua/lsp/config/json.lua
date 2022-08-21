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
}

return {
  on_setup = function(server, defaultOpts)
    local options = vim.tbl_deep_extend("force", opts, defaultOpts)
    server.setup(options)
  end,
}
