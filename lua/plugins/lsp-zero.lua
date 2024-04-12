return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = false,
    dependencies = {
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        -- Auto-Install LSPs, linters, formatters, debuggers
        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
        { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "saadparwaiz1/cmp_luasnip" },
        { "rafamadriz/friendly-snippets" },
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                { 'hrsh7th/cmp-nvim-lsp' },
            }
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                { 'L3MON4D3/LuaSnip' }
            },
        },
    },
    config = function()
        local lsp_zero = require('lsp-zero')

        -- my shotcuts
        local on_attach = (function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "<leader>vh", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function()vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set('n', '<leader>=', function() vim.lsp.buf.format { async = true } end, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            lsp_zero.buffer_autoformat()
        end)

        lsp_zero.on_attach(on_attach)
        -- to learn how to use mason.nvim with lsp-zero
        -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md

        require('mason').setup({})
        require('mason-tool-installer').setup({
            -- Install these linters, formatters, debuggers automatically
            ensure_installed = {
                'debugpy',
                'mypy',
            },
        })
        require('mason-lspconfig').setup({
            ensure_installed = { 'tsserver', 'rust_analyzer', 'pylsp', 'eslint', 'gopls', 'sqlls', },
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
                pylsp = function()
                    local lsp = require('lsp-zero')
                    local venv_path = os.getenv('VIRTUAL_ENV')
                    local py_path = nil
                    -- decide which python executable to use for mypy
                    if venv_path ~= nil then
                        py_path = venv_path .. "/bin/python3"
                    else
                        py_path = vim.g.python3_host_prog
                    end
                    lsp.configure('pylsp', {
                        settings = {
                            pylsp = {
                                plugins = {
                                    -- formatter options
                                    black = { enabled = false },
                                    autopep8 = { enabled = false },
                                    yapf = { enabled = false },
                                    -- linter options
                                    pylint = { enabled = false, executable = "pylint" },
                                    ruff = {
                                        -- formatter + Linter + isort
                                        enabled = true,
                                        extendSelect = { "I" },
                                        targetVersion = "py38", -- The minimum python version to target (applies for both linting and formatting).
                                        format = { "I" },       -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
                                    },
                                    pyflakes = { enabled = false },
                                    pycodestyle = { enabled = false },
                                    -- type checker
                                    pylsp_mypy = {
                                        enabled = true,
                                        report_progress = true,
                                        overrides = { "--python-executable", py_path, true },
                                        live_mode = true
                                    },
                                    -- auto-completion options
                                    jedi_completion = { fuzzy = true },
                                    -- import sorting
                                    isort = { enabled = false },
                                },
                            },
                        },
                    })
                    lsp.setup()
                end
            }
        })

        -- Autocomplete
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keyword_length = 3 },
            },
            formatting = lsp_zero.cmp_format(),

            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
        })

        -- Autoformat
        lsp_zero.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 1000,
            },
            servers = {
                ['tsserver']      = { 'javascript', 'typescript' },
                ['rust_analyzer'] = { 'rust' },
                ['gofmt']         = { 'go', 'golang' },
                ['pylsp']         = { 'python' }
            }
        })
    end
}
