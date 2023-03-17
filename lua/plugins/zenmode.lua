return {
    'folke/zen-mode.nvim',
    keys = {
        { '<leader>zz', function()
            require("zen-mode").setup {
                window = {
                    width = 90,
                    options = { }
                },
            }
            require("zen-mode").toggle()
            ColorMyPencils()
        end },
        { '<leader>zZ', function()
            require("zen-mode").setup {
                window = {
                    width = 80,
                    options = { }
                },
            }
            require("zen-mode").toggle()
            vim.opt.colorcolumn = 0
            ColorMyPencils()
        end },
    },
}
