return {
    'numToStr/Comment.nvim',
    keys = {
        {
            '<leader>/',
            '<CMD>lua require("Comment.api").toggle.linewise.current()<CR>',
            silent = true,
        },
        {
            mode = 'x',
            '<leader>/',
            '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
        },
    },
    config = function()
        require('Comment').setup()
    end
}
