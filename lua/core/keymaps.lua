local keymap = vim.keymap

-- NvimTree
keymap.set("n", "<Leader>ntt", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Git Blame
keymap.set("n", "<Leader>blm", "<cmd>GitBlameToggle<cr>", { desc = "Toggle Git Blame" })

-- Telescope
keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = "Find Files" })
keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = "Live Grep" })
keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = "Buffers" })
keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = "Help Tags" })

-- Trouble
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions (Trouble)" })
keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Todo Comments
keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next Todo" })
keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous Todo" })

-- DAP
keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = "Debug: Continue" })
keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = "Debug: Step Over" })
keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = "Debug: Step Into" })
keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = "Debug: Step Out" })
keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end, { desc = "Debug: Set Breakpoint" })
keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "Debug: Log Point" })
keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = "Debug: Open REPL" })
keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = "Debug: Run Last" })
keymap.set('n', '<Leader>duo', function() require("dapui").open() end, { desc = "Debug: Open UI" })
keymap.set('n', '<Leader>dut', function() require("dapui").toggle() end, { desc = "Debug: Toggle UI" })
keymap.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end, { desc = "Debug: Hover" })
keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end, { desc = "Debug: Preview" })

-- Rest Client
keymap.set('n', '<leader>rer', ':Rest run<CR>', { desc = "Rest: Run" })
keymap.set('n', '<leader>rel', ':Rest logs<CR>', { desc = "Rest: Logs" })

-- JQ Formatting
keymap.set("v", "<leader>jq", function()
  vim.cmd("'<,'>!jq .")
end, { desc = "Format JSON with jq" })

-- Spring Boot
keymap.set('n', '<leader>Jr', function() require("springboot-nvim").boot_run() end, {desc = "Spring Boot Run Project"})
keymap.set('n', '<leader>Jc', function() require("springboot-nvim").generate_class() end, {desc = "Java Create Class"})
keymap.set('n', '<leader>Ji', function() require("springboot-nvim").generate_interface() end, {desc = "Java Create Interface"})
keymap.set('n', '<leader>Je', function() require("springboot-nvim").generate_enum() end, {desc = "Java Create Enum"})
