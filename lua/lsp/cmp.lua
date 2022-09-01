-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/onsails/lspkind-nvim
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

-- my-snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
require("luasnip.loaders.from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  -- 补全源
 -- 来源
 sources = {
   { name = "luasnip", group_index = 1 },
   { name = "nvim_lsp", group_index = 1 },
   { name = "nvim_lsp_signature_help", group_index = 1 },
   { name = "nvim_lua", group_index = 2 },
   { name = "vsnip", group_index = 2 },
   { name = "buffer", group_index = 2 },
   { name = "path", group_index = 2 },
 },
  -- 快捷键设置
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-,>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
    "i",
    "s",
  }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, {
  "i",
  "s",
  })}),
  -- 使用lspkind-nvim显示类型图标 (新增)
  formatting = require('lsp.ui').formatting,
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true,
  },
})

-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- luasnip expand 配置
vim.keymap.set({ "i", "s" }, '<C-l>', function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end)

vim.keymap.set({ "i", "s" }, '<C-h>', function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end)

vim.keymap.set({ "i", "s" }, '<C-j>', function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

vim.keymap.set({ "i", "s" }, '<C-k>', function()
  if luasnip.choice_active() then
    luasnip.change_choice(-1)
  end
end)

