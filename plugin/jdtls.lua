local java_cmds = vim.api.nvim_create_augroup('java_cmds', {clear = true})
local cache_vars = {}

local root_markers = {
    '.git',
    'mvnw',
    'gradlew',
    'pom.xml',
    'build.gradle',
}

local features = {
    -- change this to `true` to enable codelens
    codelens = false,

    -- change this to `true` if you have `nvim-dap`,
    -- `java-test` and `java-debug-adapter` installed
    debugger = false,
}

local function get_jdtls_paths()
    if cache_vars.paths then
        return cache_vars.paths
    end

    local path = {}

    path.data_dir = vim.fn.stdpath('cache') .. '/jdtls/workspace'

    local jdtls_install = '/opt/homebrew/Cellar/jdtls/1.25.0/libexec'
    --                                  change here   ^^^^^^

    -- path.java_agent = jdtls_install .. '/lombok.jar'
    path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

    if vim.fn.has('mac') == 1 then
        path.platform_config = jdtls_install .. '/config_mac'
    elseif vim.fn.has('unix') == 1 then
        path.platform_config = jdtls_install .. '/config_linux'
    elseif vim.fn.has('win32') == 1 then
        path.platform_config = jdtls_install .. '/config_win'
    end

    path.bundles = {}

    ---
    -- Include java-test bundle if present
    ---
    -- local java_test_path = require('mason-registry')
    --   .get_package('java-test')
    --   :get_install_path()
    --
    -- local java_test_bundle = vim.split(
    --   vim.fn.glob(java_test_path .. '/extension/server/*.jar'),
    --   '\n'
    -- )
    --
    -- if java_test_bundle[1] ~= '' then
    --   vim.list_extend(path.bundles, java_test_bundle)
    -- end

    ---
    -- Include java-debug-adapter bundle if present
    ---
    -- local java_debug_path = require('mason-registry')
    --   .get_package('java-debug-adapter')
    --   :get_install_path()
    --
    -- local java_debug_bundle = vim.split(
    --   vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'),
    --   '\n'
    -- )
    --
    -- if java_debug_bundle[1] ~= '' then
    --   vim.list_extend(path.bundles, java_debug_bundle)
    -- end

    ---
    -- Useful if you're starting jdtls with a Java version that's
    -- different from the one the project uses.
    ---
    path.runtimes = {
        -- Note: the field `name` must be a valid `ExecutionEnvironment`,
        -- you can find the list here:
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        --
        {
            name = "JavaSE-1.8",
            path = "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home",
        },
        {
            name = "JavaSE-11",
            path = "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home",
        },
        {
            name = "JavaSE-17",
            path = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home",
        },
    }

    cache_vars.paths = path

    return path
end

local function enable_codelens(bufnr)
    pcall(vim.lsp.codelens.refresh)

    vim.api.nvim_create_autocmd('BufWritePost', {
        buffer = bufnr,
        group = java_cmds,
        desc = 'refresh codelens',
        callback = function()
            pcall(vim.lsp.codelens.refresh)
        end,
    })
end

local function enable_debugger(bufnr)
    require('jdtls').setup_dap({hotcodereplace = 'auto'})
    require('jdtls.dap').setup_dap_main_class_configs()

    local opts = {buffer = bufnr}
    vim.keymap.set('n', '<leader>df', "<cmd>lua require('jdtls').test_class()<cr>", opts)
    vim.keymap.set('n', '<leader>dn', "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)
end

local function jdtls_on_attach(client, bufnr)
    if features.debugger then
        enable_debugger(bufnr)
    end

    if features.codelens then
        enable_codelens(bufnr)
    end

    -- The following mappings are based on the suggested usage of nvim-jdtls
    -- https://github.com/mfussenegger/nvim-jdtls#usage

    local opts = {buffer = bufnr}
    vim.keymap.set('n', '<A-o>', "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
    vim.keymap.set('n', 'crv', "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
    vim.keymap.set('x', 'crv', "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
    vim.keymap.set('n', 'crc', "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
    vim.keymap.set('x', 'crc', "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
    vim.keymap.set('x', 'crm', "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)

    -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    -- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    -- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

local function jdtls_setup(event)
    local jdtls = require('jdtls')

    local path = get_jdtls_paths()
    local data_dir = path.data_dir .. '/' ..  vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    if cache_vars.capabilities == nil then
        jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

        local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
        cache_vars.capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        ok_cmp and cmp_lsp.default_capabilities() or {}
        )
    end

    local cmd = {
        -- The command that starts the language server
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        -- 💀
        '/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/bin/java', -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        -- 💀
        '-jar',
        path.launcher_jar,
        -- 💀
        '-configuration',
        path.platform_config,
        -- 💀
        -- See `data directory configuration` section in the README
        '-data',
        data_dir,
    }

    local settings = {
        java = {
            -- jdt = {
            --     ls = {
            --         vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
            --     }
            -- },
            -- eclipse = { downloadSources = true },
            -- maven = { downloadSources = true },
            signatureHelp = { enabled = true },
            import = { enabled = true },
            rename = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            configuration = {
                updateBuildConfiguration = 'interactive',
                runtimes = path.runtimes,
            },
            -- implementationsCodeLens = { enabled = true },
            -- referencesCodeLens = { enabled = true },
            -- inlayHints = {
            --   parameterNames = {
            --     enabled = 'all' -- literals, all, none
            --   }
            -- },
            format = {
                enabled = true,
                -- settings = {
                --     profile = 'asdf'
                -- },
            }
        },
        completion = {
            favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
            },
        },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            }
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            },
            hashCodeEquals = {
                useJava7Objects = false,
            },
            useBlocks = true,
        },
    }

    -- This starts a new client & server,
    -- or attaches to an existing client & server depending on the `root_dir`.
    jdtls.start_or_attach({
        cmd = cmd,
        settings = settings,
        on_attach = jdtls_on_attach,
        capabilities = cache_vars.capabilities,
        root_dir = jdtls.setup.find_root(root_markers),
        flags = {
            allow_incremental_sync = true,
        },
        init_options = {
            bundles = path.bundles,
        },
    })
end

vim.api.nvim_create_autocmd('FileType', {
    group = java_cmds,
    pattern = {'java'},
    desc = 'Setup jdtls',
    callback = jdtls_setup,
})
