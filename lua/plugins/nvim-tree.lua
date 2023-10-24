return {
    'nvim-tree/nvim-tree.lua',
    requires = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        {
            "<leader>pv",
            "<CMD>NvimTreeToggle<CR>",
            mode = { 'n' },
            desc = 'Toggle Project View'
        }
    },
    opts = {
        view = {
            width = 30,
        },
    }
}
