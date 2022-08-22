-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local opts = {
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = {
    debounce_text_changes = 300,
  },
  -- https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils/blob/main/lua/nvim-lsp-ts-utils/utils.lua
  -- 传入 tsserver 初始化参数
  -- make inlay hints work
  init_options = {
    hostInfo = "neovim",
    preferences = {
      -- includeInlayParameterNameHints = "all",
      -- includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      -- includeInlayFunctionParameterTypeHints = true,
      -- includeInlayVariableTypeHints = true,
      -- includeInlayPropertyDeclarationTypeHints = true,
      -- includeInlayFunctionLikeReturnTypeHints = true,
      -- includeInlayEnumMemberValueHints = true,
    },
  },
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- 绑定快捷键
    require('keybindings').mapLSP(buf_set_keymap)
    -- 保存时自动格式化
    -- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')

    -- TypeScript 增强
    local ts_status_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")
    if not ts_status_ok then
      return
    end
    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,
      -- import all
      import_all_timeout = 5000, -- ms
      -- lower numbers = higher priority
      import_all_priorities = {
        same_file = 1, -- add to existing import statement
        local_files = 2, -- git files or files with relative path markers
        buffer_content = 3, -- loaded buffer content
        buffers = 4, -- loaded buffer names
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,
      -- if false will avoid organizing imports
      always_organize_imports = true,
      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      -- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
      filter_out_diagnostics_by_code = { 80001 },
      -- inlay hints
      auto_inlay_hints = true,
      inlay_hints_highlight = "Comment",
      inlay_hints_priority = 200, -- priority of the hint extmarks
      inlay_hints_throttle = 150, -- throttle the inlay hint request
      inlay_hints_format = { -- format options for individual hint kind
        Type = {},
        Parameter = {},
        Enum = {},
        -- Example format customization for `Type` kind:
        -- Type = {
        --     highlight = "Comment",
        --     text = function(text)
        --         return "->" .. text:sub(2)
        --     end,
        -- },
      },

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,
    })
    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end
    illuminate.on_attach(client)
  end,
}

return {
  on_setup = function(server, defaultOpts)
    local options = vim.tbl_deep_extend("force", defaultOpts, opts)
    server.setup(options)
  end,
}
