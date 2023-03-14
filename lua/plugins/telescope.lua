return {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    branch = '0.1.x',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
        { '<C-t>', '<CMD>Telescope<CR>', mode = { 'n', 'v' } },
        { '<leader>pf', '<CMD>Telescope find_files<CR>' },
        { '<C-p>', '<CMD>Telescope git_files<CR>' },
        { '<C-l>', '<CMD>Telescope live_grep<CR>' },
        { '<C-c>', '<CMD>Telescope commands<CR>' },
        { '<C-k>', '<CMD>Telescope keymaps<CR>' },
        { '<leader>ps', '<CMD>Telescope grep_string<CR>', mode = { 'n', 'v' } },
        { '<leader>vh', '<CMD>Telescope help_tags<CR>' },
    },
    config = true,
}
