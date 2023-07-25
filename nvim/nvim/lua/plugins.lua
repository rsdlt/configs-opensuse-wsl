return require('packer').startup(function()
  -- Git
  use "tpope/vim-fugitive"

  -- Oil
  use 'stevearc/oil.nvim'

  -- Trouble
  use 'folke/trouble.nvim'

  -- Hop
  use { 'phaazon/hop.nvim', branch = 'v2' } -- Navitage to any word in the file

  -- Neoscroll
  use 'karb94/neoscroll.nvim'

  -- Auto complete web tags
  use "windwp/nvim-ts-autotag"

  -- Tmux navigator
  use 'christoomey/vim-tmux-navigator'

  -- Zig
  use("ziglang/zig.vim")

  -- Packer
  use("wbthomason/packer.nvim")

  -- Autopairs
  use "windwp/nvim-autopairs"

  -- Colorschema
  use "folke/tokyonight.nvim"
  use "loctvl842/monokai-pro.nvim"


  -- Treesitter better syntax
  use 'nvim-treesitter/nvim-treesitter'

  -- Manage LSPs and DAPs
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  -- Rust Tools
  use 'simrat39/rust-tools.nvim'

  -- Completion
  use 'onsails/lspkind.nvim'     -- shows icons in cmp
  use 'hrsh7th/nvim-cmp'         -- Completion framework
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'     -- LSP completion source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip'        -- Snippet completion source for nvim-cmp
  use 'hrsh7th/cmp-path'         -- Useful completion sources
  use 'hrsh7th/cmp-buffer'       -- Useful completion sources
  use 'L3MON4D3/LuaSnip'         -- snippets for completion
  use 'saadparwaiz1/cmp_luasnip' -- snippets for completion'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2', requires = { { 'nvim-lua/plenary.nvim' } }

  }

  -- Fidget
  use { 'j-hui/fidget.nvim', tag = 'legacy' }

  -- Vim Surround
  use 'tpope/vim-surround' -- Add "", '', (),

  -- Nerdtree and Lualine
  use { 'kyazdani42/nvim-tree.lua',             -- Filesystem navigation
    requires = 'kyazdani42/nvim-web-devicons' } -- Filesystem icons
  use { 'nvim-lualine/lualine.nvim',            -- Statusline
    requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

  -- Better escape with jj or jk
  use "max397574/better-escape.nvim"

  -- Enable comments
  use 'numToStr/Comment.nvim'

  -- Breadcrumbs nav bar
  use "SmiteshP/nvim-navic"
  use "utilyre/barbecue.nvim"
end)
