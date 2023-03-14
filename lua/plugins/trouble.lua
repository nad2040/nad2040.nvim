return {
    'folke/trouble.nvim',
    keys = {
        { '<leader>xq', '<CMD>TroubleToggle quickfix<CR>', mode = 'n', silent = true, noremap = true },
        -- {'n', '<leader>xd', 'TroubleToggle lsp_document_diagnostics'},
        -- {'n', '<leader>xl', 'TroubleToggle lsp_location_list'},
        -- {'n', '<leader>xw', 'TroubleToggle lsp_workspace_diagnostics'},
    },
    config = function()
        require('trouble').setup {
            icons = false,
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    end
}
