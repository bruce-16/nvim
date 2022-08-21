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
}

return {
  on_setup = function(server, defaultOpts)
    local options = vim.tbl_deep_extend("force", opts, defaultOpts)
    server.setup(options)
  end,
}
