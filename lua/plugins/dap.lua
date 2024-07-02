return {
    {
        'mfussenegger/nvim-dap',
    },
    {
        'rcarriga/nvim-dap-ui',
        -- enabled=false,
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            vim.keymap.set('n', '<F10>', function() dap.step_over() end)
            vim.keymap.set('n', '<F11>', function() dap.step_into() end)
            vim.keymap.set('n', '<F12>', function() dap.step_out() end)
            vim.keymap.set('n', '<leader>dk', function() dap.continue() end)
            vim.keymap.set('n', '<leader>dl', function() dap.run_last() end)
            vim.keymap.set('n', '<leader>dui', function() dapui.toggle() end)
            vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end)

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },
}
