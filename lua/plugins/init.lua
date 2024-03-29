return {
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-context',
    {
        'eandrju/cellular-automaton.nvim',
        keys = { { '<leader>mr', '<CMD>CellularAutomaton make_it_rain<CR>' } },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("lualine").setup {
                options = {
                    theme = 'tokyonight'
                }
            }
        end,
    },
    'mfussenegger/nvim-jdtls',
}
