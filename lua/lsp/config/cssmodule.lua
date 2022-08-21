-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssmodules_ls
local runtime_path = vim.split(package.path, ';')
local util = require "lspconfig".util
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local opts = {
  settings = {
    cmd = { "cssmodules-language-server" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
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
