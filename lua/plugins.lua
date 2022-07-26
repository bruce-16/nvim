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
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons", lock = true })
    -- bufferline
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})
    -- lualine
    use("arkav/lualine-lsp-progress")
    use({'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }})
    -- telescope
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" }, lock = true }
    -- use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim", { "kdheepak/lazygit.nvim" } } }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use("nvim-telescope/telescope-ui-select.nvim")
    use { "LinArcX/telescope-env.nvim" }
    -- dashboard-nvim (新增)
    -- use("glepnir/dashboard-nvim")
    -- project
    use("ahmedkhalf/project.nvim")
    -- treesitter （新增）
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", lock = true })
    -- 增加引号等
    use 'tpope/vim-surround'
    -- motion
    use {
      'phaazon/hop.nvim',
      branch = 'v1', -- optional but strongly recommended
    }
    -- comment
    use { "numToStr/Comment.nvim", config = function() require('Comment').setup() end }
    -- lspconfig
    use({ "williamboman/nvim-lsp-installer", lock = true })
    use({ "neovim/nvim-lspconfig", lock = true })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim", lock = true })
    -- 函数参数提示
    use "ray-x/lsp_signature.nvim"
    -- 补全引擎
    use({ "hrsh7th/nvim-cmp", lock = true })
    -- snippet 引擎
    use({ "hrsh7th/vim-vsnip", lock = true })
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
    use({ 'christoomey/vim-tmux-navigator', lock = true })
    -- autopairs
    use 'windwp/nvim-autopairs'
    -- markdown
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
    -- cursorline
    use 'yamatsum/nvim-cursorline'
    -- scroll
    use 'psliwka/vim-smoothie'
    -- which-key
    use({ "folke/which-key.nvim", lock = true })
    -- terminal
    use({ "akinsho/toggleterm.nvim", lock = true })
    -- spell checker
    use({'lewis6991/spellsitter.nvim', lock = true })

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
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
