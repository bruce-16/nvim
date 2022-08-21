-- local status, null_ls = pcall(require, "null-ls")
-- if not status then
--   vim.notify("没有找到 null-ls")
--   return
-- end
--
-- local formatting = null_ls.builtins.formatting
-- -- local diagnostics = null_ls.builtins.diagnostics
-- -- local code_actions = null_ls.builtins.code_actions
--
-- null_ls.setup({
--   debug = false,
--   sources = {
--     -- Formatting ---------------------
--     --  brew install shfmt
--     formatting.shfmt,
--     -- StyLua
--     formatting.stylua,
--     -- frontend
--     formatting.prettier.with({ -- 比默认少了 markdown
--       filetypes = {
--         "javascript",
--         "javascriptreact",
--         "typescript",
--         "typescriptreact",
--         "vue",
--         "css",
--         "scss",
--         "less",
--         "html",
--         "json",
--         "yaml",
--         "graphql",
--       },
--       prefer_local = "node_modules/.bin",
--     }),
--     -- rustfmt
--     -- rustup component add rustfmt
--     formatting.rustfmt,
--     -- Python
--     -- pip install black
--     -- asdf reshim python
--     formatting.black.with({ extra_args = { "--fast" } }),
--     -----------------------------------------------------
--     -- Ruby
--     -- gem install rubocop
--     formatting.rubocop,
--     -----------------------------------------------------
--     -- formatting.fixjson,
--     -- Diagnostics  ---------------------
--     -- diagnostics.eslint.with({
--     --   prefer_local = "node_modules/.bin",
--     -- }),
--     -- diagnostics.markdownlint,
--     -- markdownlint-cli2
--     -- diagnostics.markdownlint.with({
--     --   prefer_local = "node_modules/.bin",
--     --   command = "markdownlint-cli2",
--     --   args = { "$FILENAME", "#node_modules" },
--     -- }),
--     --
--     -- code actions ---------------------
--     -- code_actions.gitsigns,
--     -- code_actions.eslint.with({
--     --   prefer_local = "node_modules/.bin",
--     -- }),
--   },
--   -- #{m}: message
--   -- #{s}: source name (defaults to null-ls if not specified)
--   -- #{c}: code (if available)
--   diagnostics_format = "[#{s}] #{m}",
--   on_attach = function(_)
--     vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
--     -- if client.server_capabilities.document_formatting then
--     --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
--     -- end
--   end,
-- })


local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    formatting.prettier.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
      },
      prefer_local = "node_modules/.bin",
    }),
    diagnostics.flake8,
  },
}
