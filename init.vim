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

Plug 'folke/tokyonight.nvim'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}

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
call plug#end()

source ~/.config/nvim/scirpt_init.lua

colorscheme tokyonight-night

set number
set relativenumber

set clipboard=unnamed
set splitbelow

set tabstop=4
set shiftwidth=4
set noexpandtab
