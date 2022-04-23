local packer = require("packer")
packer.startup(
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    -- 主题
    use 'folke/tokyonight.nvim'
    use 'navarasu/onedark.nvim'
    use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
    use 'shaunsingh/nord.nvim'
    -- tree
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
    -- bufferline
    -- use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})
    -- lualine
    use("arkav/lualine-lsp-progress")
    use({'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }})
    -- telescope
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
    -- use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim", { "kdheepak/lazygit.nvim" } } }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { "LinArcX/telescope-env.nvim" }
    -- dashboard-nvim (新增)
    -- use("glepnir/dashboard-nvim")
    -- project
    use("ahmedkhalf/project.nvim")
    -- treesitter （新增）
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    -- 自动增加引号等
    use 'tpope/vim-surround'
    -- motion
    use {
      'phaazon/hop.nvim',
      branch = 'v1', -- optional but strongly recommended
    }
    -- comment
    use "terrortylor/nvim-comment"
    -- lspconfig
    use({ "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer" })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" })
    -- 函数参数提示
    use "ray-x/lsp_signature.nvim"
    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")
    -- 代码格式化
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
    -- git
    use 'lewis6991/gitsigns.nvim'
    -- git diff
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    -- 补全 ui 插件
    -- 图标集
    use 'onsails/lspkind-nvim'
    use 'tami5/lspsaga.nvim'
    -- replace
    use 'brooth/far.vim'
    -- tmux + vim navigator
    use 'christoomey/vim-tmux-navigator'
    -- autopairs
    use 'windwp/nvim-autopairs'
    -- markdown
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
    -- close buffers
    use 'kazhala/close-buffers.nvim'
    -- marks
    use 'chentau/marks.nvim'
    -- cursorline
    use 'yamatsum/nvim-cursorline'
end)

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
