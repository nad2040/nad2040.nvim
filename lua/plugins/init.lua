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
        dependencies = "nvim-tree/nvim-web-devicons",
        config = true,
    },
    'mfussenegger/nvim-jdtls',
}
