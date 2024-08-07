return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("todo-comments").setup {
            highlight = {
                pattern = {
                    [[.*<(KEYWORDS)\s*:]],
                    [[.*<(KEYWORDS)\s*\(.*\)]]
                }
            },
            search = {
                pattern = [[\b(KEYWORDS)\s*\(.*\)]]
            }
        }
    end
}
