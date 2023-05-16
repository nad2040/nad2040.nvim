return {
    'theprimeagen/refactoring.nvim',
    lazy = false,
    dependencies = {
        {'nvim-lua/plenary.nvim'},
        {'nvim-treesitter/nvim-treesitter'}
    },
    config = function()
        require('refactoring').setup({})
        vim.api.nvim_set_keymap('v', '<leader>ri', [[<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
    end,
}
