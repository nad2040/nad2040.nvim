return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
        lazy = true,
        config = true,
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = {
                    -- Copilot Source
                    { name = "copilot",                 group_index = 2 },
                    -- Other Sources
                    { name = 'nvim_lsp_signature_help', group_index = 2 },
                    { name = "nvim_lsp",                group_index = 2 },
                    { name = "path",                    group_index = 2 },
                    { name = "luasnip",                 group_index = 2 },
                    { name = "emmet_ls",                group_index = 2 },
                },
                formatting = lsp_zero.cmp_format({ details = true }),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<CR>'] = cmp.mapping.confirm({
                        -- documentation says this is important.
                        -- I don't know why.
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                    ['<Tab>'] = nil, --[[ cmp_action.luasnip_supertab(), ]]
                    ['<S-Tab>'] = nil, --[[ cmp_action.luasnip_shift_supertab(), ]]
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })
        end
    },
    -- LSP
    {
        'williamboman/mason-lspconfig.nvim',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/cmp-nvim-lsp' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()
            -- .preset({
            --     set_lsp_keymaps = { preserve_mappings = false },
            -- })

            -- lsp.omnifunc.setup({
            --     tabcomplete = true,
            --     use_fallback = true,
            --     update_on_delete = true,
            -- })

            lsp_zero.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                local wk = require('which-key')
                wk.register({
                    -- LSP actions
                    ["K"] = { function() vim.lsp.buf.hover() end, "Hover" },
                    ["gd"] = { function() vim.lsp.buf.definition() end, "Go to Definition" },
                    ["gD"] = { function() vim.lsp.buf.declaration() end, "Go to Declaration" },
                    ["<leader>vws"] = { function() vim.lsp.buf.workspace_symbol() end, "Workspace symbol" },
                    ["<leader>vca"] = { function() vim.lsp.buf.code_action() end, "View code actions" },
                    ["<leader>vrn"] = { function() vim.lsp.buf.rename() end, "Rename" },
                    ["<leader>vrr"] = { function() vim.lsp.buf.references() end, "References" },
                    ["<leader>H"] = { function() vim.lsp.inlay_hint(bufnr, nil) end, "Toggle Inlay Hints" },
                    -- Diagnostics
                    ["<leader>vd"] = { function() vim.diagnostic.open_float() end, "Open diagnostic" },
                    ["[d"] = { function() vim.diagnostic.goto_prev() end, "Previous diagnostic" },
                    ["]d"] = { function() vim.diagnostic.goto_next() end, "Next diagnostic" },
                    ["<leader>f"] = { function() vim.lsp.buf.format() end, "Format" },
                }, { buffer = bufnr })
                wk.register({
                    ["<C-h>"] = { function() vim.lsp.buf.signature_help() end, "Signature help" }
                }, { mode = "i", buffer = bufnr })

                -- vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
                -- vim.api.nvim_create_autocmd("InsertEnter", {
                --     buffer = bufnr,
                --     callback = function() vim.lsp.inlay_hint(bufnr, true) end,
                --     group = "lsp_augroup",
                -- })
                -- vim.api.nvim_create_autocmd("InsertLeave", {
                --     buffer = bufnr,
                --     callback = function() vim.lsp.inlay_hint(bufnr, false) end,
                --     group = "lsp_augroup",
                -- })
            end)

            -- Fix Undefined global 'vim'
            lsp_zero.configure('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        hint = {
                            enable = true,
                        },
                    }
                }
            })

            lsp_zero.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = 'E',
                    warn = 'W',
                    hint = 'H',
                    info = 'I'
                }
            })

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'clangd',
                    'jdtls',
                    'lua_ls',
                    'pyright',
                    'rust_analyzer',
                    'ocamllsp',
                    'pest_ls',
                    'tsserver',
                },
                handlers = {
                    lsp_zero.default_setup,
                    pest_ls = function()
                        require('lspconfig').pest_ls.setup({
                            filetypes = { "pest" }
                        })
                    end,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls())
                    end,
                    emmet_ls = function()
                        require('lspconfig').emmet_ls.setup({
                            -- on_attach = on_attach,
                            filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass",
                                "scss", "svelte", "pug", "typescriptreact", "vue" },
                            init_options = {
                                html = {
                                    options = {
                                        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                                        ["bem.enabled"] = true,
                                    },
                                },
                            }
                        })
                    end,
                    jdtls = lsp_zero.noop,
                }
            })

            lsp_zero.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ['lua_ls'] = { 'lua' },
                    ['rust_analyzer'] = { 'rust' },
                    ['ocamllsp'] = { 'ocaml' },
                    -- if you have a working setup with null-ls
                    -- you can specify filetypes it can format.
                    -- ['null-ls'] = { "ocaml" },
                }
            })

            vim.diagnostic.config({
                virtual_text = true
            })
        end
    }
}
