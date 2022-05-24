-- map('模式', '按键', '映射lsp_finder为', 'options')
local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
--
-- 左右比例控制
map("n", "s,", ":vertical resize -15<CR>", opt)
map("n", "s.", ":vertical resize +15<CR>", opt)
-- 上下比例
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)
-- Terminal相关
map("n", "<leader>t", ":sp | terminal<CR>", opt)
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
--
-- 上下滚动浏览
map("n", "<C-u>", "10k", opt)
map("n", "<C-d>", "10j", opt)

-- 退出
map("n", "<leader>q", ":q<CR>", opt)
map("n", "<leader>qq", ":q!<CR>", opt)
map("n", "<leader>Q", ":qa!<CR>", opt)
-- 保存
map("n", "<leader>s", ":w<CR>", opt)
-- mention
map("n", "H", "^", opt);
map("n", "L", "$", opt);

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)
-- insert 模式下，jk 表示 esj
map("i", "jk", "<ESC>", opt)
-- 重新加载配置文件
map("n", "<leader>vr", ":source ~/.config/nvim/init.lua<CR>", opt)
-- 取消搜索高亮
map("n", "<c-n>", ":nohls<CR>", opt)
-- 折叠块
map('n', 'za', ':foldclose<CR>', opt)
map('n', 'az', ':foldopen<CR>', opt)

-- ===========
-- 插件快捷键
-- ===========
local pluginKeys = {}
-- ===========
-- =========== nvim-tree
-- ===========
-- alt + m 键打开关闭tree
map("n", "tt", ":NvimTreeToggle<CR>", opt)
-- 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- 显示隐藏文件
  { key = "i", action = "toggle_ignored" }, -- Ignore (node_modules)
  { key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
  -- 文件操作
  { key = "<F5>", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "s", action = "system_open" },
}

-- ============
-- ============ -- bufferline
-- ============
-- 关闭
map("n", "<leader>q", ":Bdelete!<CR>", opt)

pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    -- ["<C-j>"] = "move_selection_next",
    -- ["<C-k>"] = "move_selection_previous",
    -- 历史记录
    -- ["<C-n>"] = "cycle_history_next",
    -- ["<C-p>"] = "cycle_history_prev",
    -- 关闭窗口
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
  n = {
    ["<C-o>"] = 'delete_buffer',
  }
}

--===========
--=========== lsp 回调函数快捷键设置
--===========
-- [[
-- 大部分迁移到 which-key
-- ]]
pluginKeys.mapLSP = function(mapbuf)
  mapbuf("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
end

--===========
--=========== nvim-cmp 自动补全
--===========
pluginKeys.cmp = function(cmp)
  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  return {
    -- 出现补全
    ["<C->"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
    -- 取消
    ["<C-,>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close()
    }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    -- 确认
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace
    }),
    -- 如果窗口内容太多，可以滚动
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),

    -- 自定义代码段跳转到下一个参数
    ["<C-l>"] = cmp.mapping(function(_)
      if vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      end
    end, {"i", "s"}),
    -- 自定义代码段跳转到上一个参数
    ["<C-h>"] = cmp.mapping(function()
      if vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, {"i", "s"}),

    -- Super Tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, {"i", "s"}),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, {"i", "s"})
  }
end

--========
--======== gitsigns
--========
-- [[
-- 迁移到 which-key
-- ]]
pluginKeys.mapGitSigns = function(mapbuf)
--
end

-- ======
-- ====== 函数参数提示
-- ======
pluginKeys.lsp_signature_key = '<C-j>'

-- ====
-- ==== hop
-- ====
map("n", "<leader><leader>w", ":HopWord<CR>", opt)
map("n", "<leader><leader>b", ":HopWordBC<CR>", opt)
map("n", "<leader><leader>j", ":HopLineAC<CR>", opt)
map("n", "<leader><leader>k", ":HopLineBC<CR>", opt)
map("n", "<leader><leader>/", ":HopPattern", opt)
map("n", "<leader><leader>l", ":HopWordCurrentLineAC<CR>", opt)
map("n", "<leader><leader>h", ":HopWordCurrentLineBC<CR>", opt)

pluginKeys.whichKeyMapForNormal = {
  ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
  ["f"] = { require("plugin-config.telescope.custom-finder").find_project_files, "Find File" },
  -- lsp 基本操作
  ["gh"] = { vim.lsp.buf.hover, "Show hover" },
  ["gd"] = { vim.lsp.buf.definition, "Goto Definition" },
  ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
  ["gr"] = { vim.lsp.buf.references, "Goto references" },
  ["gI"] = { vim.lsp.buf.implementation, "Goto Implementation" },
  ["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
  ["gp"] = { vim.diagnostic.open_float, "Peek definition" },
  ["gl"] = {
    function()
      local config = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        format = function(d)
          local t = vim.deepcopy(d)
          local code = d.code or (d.user_data and d.user_data.lsp.code)
          if code then
            t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
          end
          return t.message
        end,
      }
      config.scope = "line"
      vim.diagnostic.open_float(0, config)
    end,
    "Show line diagnostics",
  },
  -- git 相关
  g = {
    name = "git",
    j = { "<cmd>Gitsigns next_hunk<CR>", "Next Hunk"},
    k = { "<cmd>Gitsigns prev_hunk<CR>", "Pervious Hunk"},
    s = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk"},
    R = { "<cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },
    p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk"},
    b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle Current Line Blame"},
    d = { "<cmd>Gitsigns diffthis HEAD<CR>", "Git Diff"},
    f = { "<cmd>Telescope git_status<CR>" , "Open Changed File" },
    o = { "<cmd>Telescope git_branches<CR>", "Checkout Branch" },
    c = { "<cmd>Telescope git_bcommits<CR>", "Checkout Commit(for current file)" },
  },
  b = {
    name = "Buffers",
    j = { "<cmd>BufferLinePick<CR>", "Jump" },
    f = { "<cmd>Telescope buffers<CR>", "Find" },
    e = {
      "<cmd>BufferLinePickClose<CR>",
      "Pick which buffer to close",
    },

  -- 左右Tab切换
    h = { "<cmd>BufferLineCyclePrev<CR>", "BufferLine Previous"},
    l = { "<cmd>BufferLineCycleNext<CR>", "BufferLine Next"},
    H = { "<cmd>BufferLineCloseLeft<CR>", "Close all to the left" },
    L = { "<cmd>BufferLineCloseRight<CR>", "Close all to the right" },
    D = {
      "<cmd>BufferLineSortByDirectory<CR>",
      "Sort by directory",
    },
    S = {
      "<cmd>BufferLineSortByExtension<CR>",
      "Sort by language",
    },
  },
  l = {
    name = "lsp",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>", "Buffer Diagnostics" },
    w = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
    i = { "<cmd>LspInfo<CR>", "Info" },
    I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
    j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },
    l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<CR>", "Find File" },
    h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    R = { "<cmd>Telescope registers<CR>", "Registers" },
    t = { "<cmd>Telescope live_grep<CR>", "Text" },
    k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
    C = { "<cmd>Telescope commands<CR>", "Commands" },
    p = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<CR>",
      "Colorscheme with Preview",
    },
  },
  T = {
    name = "Treesitter",
    i = { ":TSConfigInfo<cr>", "Info" },
  },
}

pluginKeys.whichKeyMapForVisual = {
  g = {
    name = "git",
    s = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Chunk"},
  }
}

return pluginKeys
