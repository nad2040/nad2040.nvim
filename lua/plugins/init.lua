return {
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-context',
    'github/copilot.vim',
    {
        'eandrju/cellular-automaton.nvim',
        keys = { { '<leader>mr', '<CMD>CellularAutomaton make_it_rain<CR>' } },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = true,
    },
    'mfussenegger/nvim-jdtls',
}
