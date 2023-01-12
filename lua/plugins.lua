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
    -- packer plugin
    use 'wbthomason/packer.nvim'

    -- colorschemes
    use 'folke/tokyonight.nvim'
    use 'navarasu/onedark.nvim'
    use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
    use 'onsails/lspkind-nvim'

    -- project
    -- use("ahmedkhalf/project.nvim")
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons", commit = "4a01f90" })
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }, commit = "0606cee" })
    use("arkav/lualine-lsp-progress")
    use({'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true, commit = "edca2b0" }})
    use 'psliwka/vim-smoothie' -- scroll
    use({ 'christoomey/vim-tmux-navigator' }) -- tmux + vim navigator
    use({ "akinsho/toggleterm.nvim" }) -- terminal
    use({ "folke/which-key.nvim", commit = "6885b66" }) -- which-key
    use { "lewis6991/impatient.nvim" }
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim", commit = "5fadc24" } }
    
    -- telescope 增强
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use({ "nvim-telescope/telescope-ui-select.nvim" })
    use { "LinArcX/telescope-env.nvim" }

    -- coding plugin
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", commit = "5d11dfc" })
    use { 'kylechui/nvim-surround', tag = "main" } -- 增加引号等
    use { 'phaazon/hop.nvim', branch = 'v2.0', commit = "2a1b686" } -- motion
    use { "numToStr/Comment.nvim", commit = "d30f2b0" } -- comment
    use 'brooth/far.vim' -- replace
    use 'windwp/nvim-autopairs' -- autopairs
    use ({ 'JoosepAlviste/nvim-ts-context-commentstring' })

    -- snippets
    use { "L3MON4D3/LuaSnip", commit = "8f8d493" } --snippet engine
    use("rafamadriz/friendly-snippets")

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp", commit = "0e436ee" })
    use { "saadparwaiz1/cmp_luasnip" }
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

    -- git
    use 'lewis6991/gitsigns.nvim'

    -- lsp installer
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })

    -- lsp
    use({ "neovim/nvim-lspconfig", commit = "9d4b8d3" })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim", commit = "0a6a16e" })
    use "ray-x/lsp_signature.nvim"
    use ({ 'glepnir/lspsaga.nvim', commit = "5f17b9b" })
    use { "RRethy/vim-illuminate", commit = "0603e75" }
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim", commit = "8be9f4f" })

    -- dap

    -- JSON 增强
    use("b0o/schemastore.nvim")
    -- Rust 增强
    use("simrat39/rust-tools.nvim")
    -- Lua 增强
    use "folke/neodev.nvim"
    -- comment 增强，jsdoc、tsdoc 等
    use { "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" }

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
