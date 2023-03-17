return {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    keys = {
        -- { '<leader>gshb', function() gs.blame_line{full=true} end },
        { '<leader>gstb', '<CMD>Gitsigns toggle_current_line_blame<CR>' },
        { '<leader>gstd', '<CMD>Gitsigns toggle_deleted<CR>' },
        { '<leader>gss', '<CMD>Gitsigns stage_hunk<CR>' },
        { '<leader>gsu', '<CMD>Gitsigns undo_stage_hunk<CR>' },
        { '<leader>gsr', '<CMD>Gitsigns reset_hunk<CR>' },
        { '<leader>gsS', '<CMD>Gitsigns stage_buffer<CR>' },
        { '<leader>gsR', '<CMD>Gitsigns reset_buffer<CR>' },
        { '<leader>gsp', '<CMD>Gitsigns preview_hunk<CR>' },
        { '<leader>gsd', '<CMD>Gitsigns diffthis<CR>' },
        -- { '<leader>gsD', function() gs.diffthis('~') end },
    },
    config = function()
        require('gitsigns').setup()
    end
}
