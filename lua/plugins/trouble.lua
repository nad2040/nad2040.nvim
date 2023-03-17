return {
    'folke/trouble.nvim',
    keys = {
        { '<leader>ttf', '<CMD>TroubleToggle quickfix<CR>', silent = true, noremap = true },
        { '<leader>ttdd', 'TroubleToggle lsp_document_diagnostics'},
        { '<leader>ttl', 'TroubleToggle lsp_location_list'},
        { '<leader>ttdw', 'TroubleToggle lsp_workspace_diagnostics'},
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
