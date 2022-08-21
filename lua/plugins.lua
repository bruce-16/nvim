-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("正在安装Pakcer.nvim，请稍后...")
  PACKER_BOOTSTRAP = fn.system({
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

packer.startup({
  function(use)
    -- colorschemes
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'navarasu/onedark.nvim'
    use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
    use 'onsails/lspkind-nvim'

    -- project
    use("ahmedkhalf/project.nvim")
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons", commit = "09a5126" })
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }, commit = "06eb4ad" })
    use("arkav/lualine-lsp-progress")
    use({'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true, commit = "c0510dd" }})
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim", commit = "d793de0" } }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make', commit = "6791f74" }
    use({ "nvim-telescope/telescope-ui-select.nvim", commit = "62ea5e5" })
    use { "LinArcX/telescope-env.nvim" }
    use 'psliwka/vim-smoothie' -- scroll
    use({ 'christoomey/vim-tmux-navigator', commit = "9ca5bfe" }) -- tmux + vim navigator
    use({ "akinsho/toggleterm.nvim" }) -- terminal
    use({ "folke/which-key.nvim", commit = "bd4411a" }) -- which-key

    -- coding plugin
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", commit = "d76b0de" })
    use 'tpope/vim-surround' -- 增加引号等
    use { 'phaazon/hop.nvim', branch = 'v2.0', commit = "2a1b686" } -- motion
    use { "numToStr/Comment.nvim", commit = "ae8c440", config = function() require('Comment').setup() end } -- comment
    use 'brooth/far.vim' -- replace
    use 'yamatsum/nvim-cursorline'
    use 'windwp/nvim-autopairs' -- autopairs
    -- use({'lewis6991/spellsitter.nvim', lock = true, config = function() require('spellsitter').setup({ enable = true }) end }) -- spell checker

    -- snippets
    use { "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" } --snippet engine
    use("rafamadriz/friendly-snippets")

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp", commit = "b1ebdb0" })
    use("hrsh7th/cmp-vsnip")
    use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    -- 代码格式化
    -- use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
    -- git
    use 'lewis6991/gitsigns.nvim'

    -- lsp
    use({ "williamboman/nvim-lsp-installer", commit = "ae913cb" })
    use({ "neovim/nvim-lspconfig", commit = "da7461b" })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim", commit = "0a6a16e" })
    use "ray-x/lsp_signature.nvim"
    use ({ 'glepnir/lspsaga.nvim', commit = "8ca757a" })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
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
