return {
  -- Colorschemes
  { 'bluz71/vim-nightfly-colors', name = 'nightfly', lazy = false, priority = 1000 },
  { 
    'folke/tokyonight.nvim', 
    lazy = false, 
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-moon]])
    end
  },

  -- Icons
  { 'nvim-tree/nvim-web-devicons', config = true },

  -- File Explorer
  { 
    'nvim-tree/nvim-tree.lua', 
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local status, nvim_tree = pcall(require, "nvim-tree")
      if status then nvim_tree.setup() end
    end
  },

  -- LSP / Mason / Completion (Consolidated for reliability)
  {
    'williamboman/mason.nvim',
    lazy = false,
    build = ":MasonUpdate",
    config = function()
      local status, mason = pcall(require, "mason")
      if status then mason.setup() end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = { 
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp' 
    },
    config = function()
      -- Use a small delay on the very first run to ensure plugins are fully indexed
      vim.schedule(function()
        local status_lsp, lspconfig = pcall(require, 'lspconfig')
        local status_mason_lsp, mason_lspconfig = pcall(require, 'mason-lspconfig')
        
        if not (status_lsp and status_mason_lsp) then return end

        local capabilities = {}
        local status_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
        if status_cmp then
          capabilities = cmp_nvim_lsp.default_capabilities()
        end

        -- Call setup for mason-lspconfig here (single point of configuration)
        mason_lspconfig.setup({
          ensure_installed = {
            'gopls', 'golangci_lint_ls', 'clangd', 'rust_analyzer',
            'pyright', 'jdtls', 'cmake', 'jsonls', 'vtsls', 'eslint',
          }
        })

        if type(mason_lspconfig.setup_handlers) == "function" then
          mason_lspconfig.setup_handlers({
            function(server_name)
              lspconfig[server_name].setup({ capabilities = capabilities })
            end,
            ["gopls"] = function()
              lspconfig.gopls.setup({
                capabilities = capabilities,
                settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true, gofumpt = true } },
              })
            end,
            ["vtsls"] = function()
              local home = os.getenv("HOME")
              local vue_plugin_path = home .. "/.nvm/versions/node/v20.15.1/lib/node_modules/@vue/language-server/"
              lspconfig.vtsls.setup({
                capabilities = capabilities,
                settings = {
                  vtsls = {
                    tsserver = {
                      globalPlugins = {
                        { name = '@vue/typescript-plugin', location = vue_plugin_path, languages = { 'vue' }, configNamespace = 'typescript' },
                      },
                    },
                  },
                },
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
              })
            end
          })
        end
      end)
    end
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip', 'L3MON4D3/LuaSnip',
    },
    config = function()
      local status, cmp = pcall(require, 'cmp')
      if not status then return end
      cmp.setup({
        snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'vsnip' } }, { { name = 'buffer' } })
      })
    end
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local status, telescope = pcall(require, 'telescope')
      if status then
        telescope.setup({ defaults = { preview = { treesitter = false } } })
      end
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    
    config = function()
      -- Register parsers (compat for plugins)
      require("nvim-treesitter.parsers")

      -- ❗ DO NOT let nvim-treesitter manage highlights
      require'nvim-treesitter'.install {
          "c", "cpp", "go", "rust", "python", "java", "lua", "bash",
          "yaml", "json", "toml", "markdown", "javascript", "typescript", "php",
      }

     -- ✅ Start Tree-sitter per buffer (Neovim-native way)
     vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,  
  },

  -- DAP
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'rcarriga/nvim-dap-ui', 'theHamsta/nvim-dap-virtual-text', 'nvim-neotest/nvim-nio' },
    config = function()
      local s1, dap = pcall(require, 'dap')
      local s2, dapui = pcall(require, 'dapui')
      if not (s1 and s2) then return end
      
      dapui.setup()
      dap.adapters.php = {
          type = "executable",
          command = "node",
          args = { os.getenv("HOME") .. "/php/vscode-php-debug/out/phpDebug.js" }
      }
      dap.configurations.php = {
        { type = 'php', request = 'launch', name = 'Listen for Xdebug', port = 9003, pathMappings = { ['/code/'] = "${workspaceFolder}" } }
      }
      dap.configurations.java = {
        { type = 'java', request = 'attach', name = "Debug (Attach) - Remote", hostName = "127.0.0.1", port = 5005 }
      }
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      local s3, vt = pcall(require, "nvim-dap-virtual-text")
      if s3 then
        vt.setup({ enabled = true, display_callback = function(variable) return variable.name .. ' = ' .. variable.value end })
      end
    end
  },
  { 'leoluz/nvim-dap-go', config = true },
  { 'mfussenegger/nvim-dap-python', config = function() 
      local status, dp = pcall(require, 'dap-python')
      if status then dp.setup('python3') end
    end 
  },

  -- Git
  { 'lewis6991/gitsigns.nvim', config = true },
  { 'f-person/git-blame.nvim' },
  { 'akinsho/git-conflict.nvim', version = "*", config = true },
  { 'sindrets/diffview.nvim' },

  -- Trouble
  { 'folke/trouble.nvim', config = true },

  -- Utils
  { 'folke/todo-comments.nvim', config = true },
  { 'Raimondi/delimitMate' },
  { 'j-hui/fidget.nvim', config = true },
  { 'jvdmeulen/json-fold.nvim' },
  
  -- Language Specific
  { 'rust-lang/rust.vim' },
  { 'charlespascoe/vim-go-syntax' },
  { 'mfussenegger/nvim-jdtls' },
  { 
    'elmcgill/springboot-nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'mfussenegger/nvim-dap' },
    config = function() 
      local status, sb = pcall(require, 'springboot-nvim')
      if status then sb.setup({}) end
    end
  },
  { 
    'rest-nvim/rest.nvim',
    config = function()
      local status, rest = pcall(require, "rest-nvim")
      if status then
        rest.setup({ result = { show_url = true, show_http_info = true, show_headers = true, formatters = { json = "jq", vnd = "jq" } } })
      end
    end
  },
  { 'iamcco/markdown-preview.nvim', build = "cd app && npx --yes yarn install" },
}
