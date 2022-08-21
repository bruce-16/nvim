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
}

return {
  on_setup = function(server, defaultOpts)
    local options = vim.tbl_deep_extend("force", opts, defaultOpts)
    server.setup(options)
  end,
}
