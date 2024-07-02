return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('tokyonight').setup({
            style = "night",
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        })
        function ColorMyPencils(color)
            color = color or "tokyonight"
            vim.cmd.colorscheme(color)
        end

        ColorMyPencils()
    end
}
