return {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    keys = {
        { '<leader>tb', '<CMD>Gitsigns toggle_current_line_blame<CR>' }
    },
    config = function()
        require('gitsigns').setup()
    end
}
