return {
    'mrjones2014/legendary.nvim',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    opts = {
        extensions = {
            lazy_nvim = true,
            which_key = {
                auto_register = true,
                do_binding = false,
            },
            -- nvim_tree = true,
            -- smart_splits = false,
            -- op_nvim = false,
            -- diffview = false,
        },
    },
    keys = {
        {
            '<C-p>',
            "<CMD>Legendary<CR>",
            mode = { 'n', 'v' },
            desc = "Command Palette"
        }
    },
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
}
