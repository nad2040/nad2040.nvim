return {
    'numToStr/Comment.nvim',
    lazy = false,
    keys = {
        {
            '<leader>/',
            '<CMD>lua require("Comment.api").toggle.linewise.current()<CR>',
            silent = true,
            desc = "toggle line comment",
        },
        {
            mode = 'x',
            '<leader>/',
            '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
            desc = "toggle line comment",
        },
    },
    config = function()
        require('Comment').setup()
    end
}
