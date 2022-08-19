-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("正在安装Pakcer.nvim，请稍后...")
  paccker_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    -- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
    install_path,
  })

  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("没有安装 packer.nvim")
  return
end

local packer = require("packer")
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    -- 主题
    use 'folke/tokyonight.nvim'
    use 'navarasu/onedark.nvim'
    use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
    -- tree
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons", commit = "09a5126" })
    -- bufferline
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }, commit = "06eb4ad" })
    -- lualine
    use("arkav/lualine-lsp-progress")
    use({'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true, commit = "c0510dd" }})
    -- telescope
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim", commit = "d793de0" } }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make', commit = "6791f74" }
    use({ "nvim-telescope/telescope-ui-select.nvim", commit = "62ea5e5" })
    use { "LinArcX/telescope-env.nvim" }
    -- dashboard-nvim
    -- use("glepnir/dashboard-nvim")
    -- project
    use("ahmedkhalf/project.nvim")
    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", commit = "d76b0de" })
    -- 增加引号等
    use 'tpope/vim-surround'
    -- motion
    use { 'phaazon/hop.nvim', branch = 'v2.0', commit = "2a1b686" }
    -- comment
    use { "numToStr/Comment.nvim", commit = "ae8c440", config = function() require('Comment').setup() end }
    -- lspconfig
    use({ "williamboman/nvim-lsp-installer", commit = "ae913cb" })
    use({ "neovim/nvim-lspconfig", commit = "da7461b" })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim", commit = "0a6a16e" })
    -- 函数参数提示
    use "ray-x/lsp_signature.nvim"
    -- 补全引擎
    use({ "hrsh7th/nvim-cmp", commit = "b1ebdb0" })
    -- snippet 引擎
    use({ "hrsh7th/vim-vsnip", commit = "8f199ef" })
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")
    -- 代码格式化
    -- use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
    -- git
    use 'lewis6991/gitsigns.nvim'
    -- 图标集
    use 'onsails/lspkind-nvim'
    use 'glepnir/lspsaga.nvim'
    -- replace
    use 'brooth/far.vim'
    -- tmux + vim navigator
    use({ 'christoomey/vim-tmux-navigator', commit = "9ca5bfe" })
    -- autopairs
    use 'windwp/nvim-autopairs'
    -- cursorline
    use 'yamatsum/nvim-cursorline'
    -- scroll
    use 'psliwka/vim-smoothie'
    -- which-key
    use({ "folke/which-key.nvim", commit = "bd4411a" })
    -- terminal
    use({ "akinsho/toggleterm.nvim" })
    -- spell checker
    -- use({'lewis6991/spellsitter.nvim', lock = true, config = function() require('spellsitter').setup({ enable = true }) end })
  end,
  config = {
    -- 锁定插件版本在snapshots目录
    -- snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
    -- 这里锁定插件版本在v1，不会继续更新插件
    -- snapshot = "v1",

    -- 最大并发数
    max_jobs = 16,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    -- display = {
    -- 使用浮动窗口显示
    --   open_fn = function()
    --     return require("packer.util").float({ border = "single" })
    --   end,
    -- },
  },
})


-- 每次保存 plugins.lua 自动安装插件
-- pcall(
--   vim.cmd,
--   [[
--     augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--     augroup end
--   ]]
-- )
