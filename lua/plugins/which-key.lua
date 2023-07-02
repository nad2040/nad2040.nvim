return {
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require("which-key")
            wk.setup ({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
            wk.register({
                a = { name = "alpha" },
                g = { name = "gitsigns/...",
                    s = { name = "gitsigns",
                        t = { name = "toggle"
                        },
                    },
                },
                t = { name = "trouble/telescope",
                    t = { name = "trouble",
                        d = { name = "diagnostics",
                        },
                    },
                    l = { name = "telescope",
                        f = { name = "find",
                        },
                    },
                },
                z = { name = "zen",
                },
            },
            {
                prefix = "<leader>"
            })
        end,
    },
}
