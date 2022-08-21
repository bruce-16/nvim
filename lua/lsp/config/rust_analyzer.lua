-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
local runtime_path = vim.split(package.path, ';')
local util = require "lspconfig".util
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local opts = {
  settings = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = util.root_pattern("Cargo.toml", "rust-project.json"),
    settings = {
      ["rust-analyzer"] = {},
    }
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
