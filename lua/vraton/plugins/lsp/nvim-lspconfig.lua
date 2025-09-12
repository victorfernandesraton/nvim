return {
    'mason-org/mason-lspconfig.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- my shotcuts
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Goto definition" })
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "Goto implementation" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { desc = "LSP hover signature_help" })
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
            { desc = "Search workspace_symbol" })
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, { desc = "Open float diagnostic" })
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, { desc = "Goto next diagnostic" })
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, { desc = "Goto prev diagnostic" })
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
        vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, { desc = "References" })
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "Rename similars" })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Goto declaration" })
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                -- Auto-format ("lint") on save.
                -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
                if client:supports_method('textDocument/formatting') then
                    vim.keymap.set('n', '<leader>==',
                        function() vim.lsp.buf.format({ bufnr = args.buf, id = client.id }) end,
                        { desc = "AutoFormat with lsp" })
                end
                -- fix hoover when not work
                -- if not client:supports_method('textDocument/hover') then
                --     vim.notify('LSP not support hover ' .. client.name, vim.log.levels.INFO, { title = 'LSP' })
                --     -- Continue execution even if hover isn't supported
                -- end
                -- -- fix completion
                if client:supports_method('textDocument/completion') then
                    vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect', 'fuzzy', 'popup', 'preview' }
                    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
                    -- remapenado para navegar no autocomplete
                    -- sendo ctrl + j para descer e ctrl + k para subir
                    vim.keymap.set('i', '<C-j>', function()
                        return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-j>'
                    end, { expr = true, silent = true, desc = "Move down in autocomplete" })
                    vim.keymap.set('i', '<C-k>', function()
                        return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-k>'
                    end, { expr = true, silent = true, desc = "Move up in autocomplete" })
                    -- atalho para abrir o autocomplete ctrl + Space
                    vim.keymap.set('i', '<C-Space>', function()
                        vim.lsp.completion.get()
                    end)
                    -- Sair do menu de completions com Esc
                    vim.api.nvim_set_keymap('i', '<Esc>', 'pumvisible() ? "<C-e>" : "<Esc>"',
                        { expr = true, noremap = true, silent = true })
                    -- Selecionar a completion
                    vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? "<C-y>" : "<CR>"',
                        { expr = true, noremap = true, silent = true })
                else
                
                    vim.notify('LSP not support completion ' .. client.name, vim.log.levels.INFO, { title = 'LSP' })
                    -- Continue execution even if hover isn't supported
                end
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
                end

                -- Optional: echo server name when attached
                -- vim.notify('LSP attached: ' .. client.name, vim.log.levels.INFO, { title = 'LSP' })

                -- vim.diagnostic.config({virtual_lines = true})
            end,
        })
        vim.lsp.config('jsonls', {
            cmd = { 'vscode-json-language-server', '--stdio' },
            filetypes = { 'json', 'jsonc' },
            init_options = {
                provideFormatter = true,
            },
            root_markers = { '.git' },
        })


        vim.diagnostic.config({
            -- virtual_text = true,
            virtual_lines = {
                current_line = true
            },
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                source = true,
            },
        })

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = {
                'denols',
                "ts_ls",
                "html",
                "cssls",
                "lua_ls",
                "ruff",
                "pylsp",
                "gopls",
                'marksman',
                'sqls',
                'bashls',
                "eslint",
                "vue_ls",
                "jsonls"
            }
        })
        vim.lsp.config('marksman', {
            cmd = { 'marksman', 'server' },
            filetypes = { 'markdown', 'markdown.mdx' },
            root_markers = { '.marksman.toml', '.git' },
        })
        vim.lsp.config('vue_ls', {
            cmd = { 'vue-language-server', '--stdio' },
            on_init = function(client)
                local retries = 0
                local function typescriptHandler(_, result, context)
                    local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })[1]
                    if not ts_client then
                        -- there can sometimes be a short delay until `ts_ls`/`vtsls` are attached so we retry for a few times until it is ready
                        if retries <= 10 then
                            retries = retries + 1
                            vim.defer_fn(function()
                                typescriptHandler(_, result, context)
                            end, 100)
                        else
                            vim.notify(
                                'Could not find `ts_ls`, `vtsls`, or `typescript-tools` lsp client required by `vue_ls`.',
                                vim.log.levels.ERROR
                            )
                        end
                        return
                    end

                    local param = unpack(result)
                    local id, command, payload = unpack(param)
                    ts_client:exec_cmd({
                        title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
                        command = 'typescript.tsserverRequest',
                        arguments = {
                            command,
                            payload,
                        },
                    }, { bufnr = context.bufnr }, function(_, r)
                        local response_data = { { id, r and r.body } }
                        client:notify('tsserver/response', response_data)
                    end)
                end

                client.handlers['tsserver/request'] = typescriptHandler
            end,
            filetypes = { 'vue' },
            root_markers = { 'package.json', 'deno.json' },
        })
        vim.lsp.config('denols', {
            cmd = { 'deno', 'lsp' },
            cmd_env = { NO_COLOR = true },
            root_dir = function(_, on_dir)
                -- TODO: para lidar com deno usando por default projetos que não possuem isso aqui
                if not vim.fs.root(0, { 'package.json', 'yarn.lock' }) then
                    on_dir(vim.fn.getcwd())
                end
            end,
            single_file_support = false,
            settings = {
                deno = {
                    enable = true,
                    suggest = {
                        imports = {
                            hosts = {
                                ['https://deno.land'] = true,
                            },
                        },
                    },
                },
            },
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        })
        vim.lsp.config('ts_ls', {
            cmd = { 'typescript-language-server', '--stdio' },
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            root_markers = { "tsconfig.json", "package.json", "yarn.lock",
                "lerna.json", "pnpm-lock.yaml", "pnpm-workspace.yaml" },
            root_dir = function(_, on_dir)
                if vim.fs.root(0, { 'tsconfig.json', "package.json" }) then
                    on_dir(vim.fn.getcwd())
                end
            end,
        })
        vim.lsp.config('eslint', {
            cmd = { 'vscode-eslint-language-server', '--stdio' },
            filetypes = {
                'javascript',
                'javascriptreact',
                'javascript.jsx',
                'typescript',
                'typescriptreact',
                'typescript.tsx',
                'vue',
                'svelte',
                'astro',
                'htmlangular',
            },
            workspace_required = true,
            on_attach = function(client, bufnr)
                vim.api.nvim_buf_create_user_command(0, 'LspEslintFixAll', function()
                    client:request_sync('workspace/executeCommand', {
                        command = 'eslint.applyAllFixes',
                        arguments = {
                            {
                                uri = vim.uri_from_bufnr(bufnr),
                                version = lsp.util.buf_versions[bufnr],
                            },
                        },
                    }, nil, bufnr)
                end, {})
            end,
            root_dir = function(bufnr, on_dir)
                -- The project root is where the LSP can be started from
                -- As stated in the documentation above, this LSP supports monorepos and simple projects.
                -- We select then from the project root, which is identified by the presence of a package
                -- manager lock file.
                local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock',
                    'deno.lock' }
                -- Give the root markers equal priority by wrapping them in a table
                root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
                    or vim.list_extend(root_markers, { '.git' })
                -- We fallback to the current working directory if no project root is found
                local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

                -- We know that the buffer is using ESLint if it has a config file
                -- in its directory tree.
                --
                -- Eslint used to support package.json files as config files, but it doesn't anymore.
                -- We keep this for backward compatibility.
                local filename = vim.api.nvim_buf_get_name(bufnr)
                local eslint_config_files_with_package_json = {
                    '.eslintrc',
                    '.eslintrc.js',
                    '.eslintrc.cjs',
                    '.eslintrc.yaml',
                    '.eslintrc.yml',
                    '.eslintrc.json',
                    'eslint.config.js',
                    'eslint.config.mjs',
                    'eslint.config.cjs',
                    'eslint.config.ts',
                    'eslint.config.mts',
                    'eslint.config.cts',
                }
                local is_buffer_using_eslint = vim.fs.find(eslint_config_files_with_package_json, {
                    path = filename,
                    type = 'file',
                    limit = 1,
                    upward = true,
                    stop = vim.fs.dirname(project_root),
                })[1]
                if not is_buffer_using_eslint then
                    return
                end

                on_dir(project_root)
            end,
            -- Refer to https://github.com/Microsoft/vscode-eslint#settings-options for documentation.
            settings = {
                validate = 'on',
                packageManager = nil,
                useESLintClass = false,
                experimental = {
                    useFlatConfig = false,
                },
                codeActionOnSave = {
                    enable = false,
                    mode = 'all',
                },
                format = true,
                quiet = false,
                onIgnoredFiles = 'off',
                rulesCustomizations = {},
                run = 'onType',
                problems = {
                    shortenToSingleLine = false,
                },
                -- nodePath configures the directory in which the eslint server should start its node_modules resolution.
                -- This path is relative to the workspace folder (root dir) of the server instance.
                nodePath = '',
                -- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
                workingDirectory = { mode = 'auto' },
                codeAction = {
                    disableRuleComment = {
                        enable = true,
                        location = 'separateLine',
                    },
                    showDocumentation = {
                        enable = true,
                    },
                },
            },
            before_init = function(_, config)
                -- The "workspaceFolder" is a VSCode concept. It limits how far the
                -- server will traverse the file system when locating the ESLint config
                -- file (e.g., .eslintrc).
                local root_dir = config.root_dir

                if root_dir then
                    config.settings = config.settings or {}
                    config.settings.workspaceFolder = {
                        uri = root_dir,
                        name = vim.fn.fnamemodify(root_dir, ':t'),
                    }

                    -- Support Yarn2 (PnP) projects
                    local pnp_cjs = root_dir .. '/.pnp.cjs'
                    local pnp_js = root_dir .. '/.pnp.js'
                    if vim.uv.fs_stat(pnp_cjs) or vim.uv.fs_stat(pnp_js) then
                        local cmd = config.cmd
                        config.cmd = vim.list_extend({ 'yarn', 'exec' }, cmd)
                    end
                end
            end,
            handlers = {
                ['eslint/openDoc'] = function(_, result)
                    if result then
                        vim.ui.open(result.url)
                    end
                    return {}
                end,
                ['eslint/confirmESLintExecution'] = function(_, result)
                    if not result then
                        return
                    end
                    return 4 -- approved
                end,
                ['eslint/probeFailed'] = function()
                    vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
                    return {}
                end,
                ['eslint/noLibrary'] = function()
                    vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
                    return {}
                end,
            },
        })
        vim.lsp.config('lua_ls', {
            cmd = { 'lua-language-server' },
            filetypes = { 'lua' },
            root_markers = { '.luarc.json', '.luarc.jsonc' },
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath('config')
                        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                    then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most
                        -- likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                        -- Tell the language server how to find Lua modules same way as Neovim
                        -- (see `:h lua-module-load`)
                        path = {
                            'lua/?.lua',
                            'lua/?/init.lua',
                        },
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = true,
                        library = {
                            vim.env.VIMRUNTIME
                        }
                    }
                })
            end,

            settings = {
                Lua = {}
            },
        })
        vim.lsp.config('gopls', {
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true,
                    },
                },
            },
        })
        --
        vim.lsp.config('ruff', {
            cmd = { 'ruff', 'server' },
            filetypes = { "python", "jupyter" },
            settings = {
            },
        })

        vim.lsp.config('pylsp', {
            cmd = { 'pylsp' },
            filetypes = { "python", "jupyter" },
            settings = {
                pylsp = {
                    skip_token_initialization = true,
                    plugins = {
                        pyflakes = { enabled = false },
                        pycodestyle = { enabled = false }
                    }
                },
            },
        })
        vim.lsp.config('cssls', {
            cmd = { 'vscode-css-language-server', '--stdio' },
            filetypes = { 'css', 'scss', 'less' },
            init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
            root_markers = { 'package.json', '.git' },
            settings = {
                css = { validate = true },
                scss = { validate = true },
                less = { validate = true },
            },
        })
        vim.lsp.config('html', {
            cmd = { 'vscode-html-language-server', '--stdio' },
            filetypes = { 'html', 'templ' },
            root_markers = { 'package.json', '.git' },
            settings = {},
            init_options = {
                provideFormatter = true,
                embeddedLanguages = { css = true, javascript = true },
                configurationSection = { 'html', 'css', 'javascript' },
            },
        })
        vim.lsp.config('sqls', {
            cmd = { 'sqls' },
            filetypes = { 'sql', 'mysql' },
            root_markers = { '*.sql' },
            settings = {},
        })
        vim.lsp.config('bashls', {
            cmd = { 'bash-language-server', 'start' },
            settings = {
                bashIde = {
                    -- Glob pattern for finding and parsing shell script files in the workspace.
                    -- Used by the background analysis features across files.

                    -- Prevent recursive scanning which will cause issues when opening a file
                    -- directly in the home directory (e.g. ~/foo.sh).
                    --
                    -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
                    globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
                },
            },
            filetypes = { 'bash', 'sh', 'zsh' },
            root_markers = { '.git' },
        })


        vim.lsp.enable({
            'denols',
            "ts_ls",
            "html",
            "cssls",
            "lua_ls",
            "ruff",
            "pylsp",
            "gopls",
            'sqls',
            'bashls',
            'marksman',
            "eslint",
            "vue_ls",
            "jsonls"
        })
    end,
}
