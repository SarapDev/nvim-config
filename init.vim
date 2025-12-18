call plug#begin()
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
"  Uncomment these if you want to manage the language servers from neovim
"  Plug 'williamboman/mason.nvim'
"  Plug 'williamboman/mason-lspconfig.nvim'

" LSP Support
Plug 'neovim/nvim-lspconfig'
" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

Plug 'L3MON4D3/LuaSnip'

Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'folke/tokyonight.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

Plug 'leoluz/nvim-dap-go'

Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'lewis6991/gitsigns.nvim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

Plug 'f-person/git-blame.nvim'

Plug 'akinsho/git-conflict.nvim'

Plug 'folke/todo-comments.nvim'

Plug 'folke/trouble.nvim'

Plug 'nvim-neotest/nvim-nio'

Plug 'Raimondi/delimitMate'

Plug 'rust-lang/rust.vim'
Plug 'charlespascoe/vim-go-syntax'

Plug 'mfussenegger/nvim-jdtls'
Plug 'elmcgill/springboot-nvim'

Plug 'nvim-lua/plenary.nvim'

Plug 'rest-nvim/rest.nvim'
Plug 'j-hui/fidget.nvim'

Plug 'jvdmeulen/json-fold.nvim'

Plug 'sindrets/diffview.nvim'
call plug#end()

source ~/.config/nvim/scirpt_init.lua

colorscheme tokyonight-moon

set number
set relativenumber

set clipboard=unnamed
set splitbelow

set tabstop=4
set shiftwidth=4
set expandtab

syntax enable
filetype plugin indent on
