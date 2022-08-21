-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local runtime_path = vim.split(package.path, ';')
local util = require "lspconfig".util
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')


local opts = {
  settings = {
    capabilities = capabilities,
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      },
      provideFormatter = true
    },
    single_file_support = true,
    root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
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
