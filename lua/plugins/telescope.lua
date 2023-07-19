return {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    branch = '0.1.x',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
        { '<leader>tl',   '<CMD>Telescope<CR>' },
        { '<leader>tlff', '<CMD>Telescope find_files<CR>' },
        { '<leader>tlg',  '<CMD>Telescope git_files<CR>' },
        { '<leader>tlfl', '<CMD>Telescope live_grep<CR>' },
        { '<leader>tlc',  '<CMD>Telescope commands<CR>' },
        { '<leader>tlk',  '<CMD>Telescope keymaps<CR>' },
        { '<leader>tlfg', '<CMD>Telescope grep_string<CR>', mode = { 'n', 'v' } },
        { '<leader>tlh',  '<CMD>Telescope help_tags<CR>' },
    },
    config = true,
}
