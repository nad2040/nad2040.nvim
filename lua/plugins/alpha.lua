return {
    'goolord/alpha-nvim',
    -- lazy = false,
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require('alpha').setup(require'alpha.themes.startify'.config)
    end,
    keys = {
        { "<leader>a", ":Alpha<CR>" },
    }
}
