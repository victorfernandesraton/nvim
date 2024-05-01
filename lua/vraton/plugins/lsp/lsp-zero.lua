return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason-lspconfig.nvim" },
        { "rafamadriz/friendly-snippets" },
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                { 'hrsh7th/cmp-nvim-lsp' },
            }
        },
    },
    config = function()
        local lsp_zero = require('lsp-zero')

        -- my shotcuts
        local on_attach = (function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set('n', '<leader>=', function() vim.lsp.buf.format { async = true } end, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        end)


        lsp_zero.on_attach(on_attach)
        lsp_zero.buffer_autoformat()

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "rust_analyzer",
                "tsserver",
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "emmet_ls",
                "pylsp",
                "gopls",
                'sqlls',
                'bashls',
                'marksman',
            },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
                -- this is the "custom handler" for `lua_ls`
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
                pylsp = function()
                    local venv_path = os.getenv('VIRTUAL_ENV')
                    local py_path = nil
                    -- decide which python executable to use for mypy
                    if venv_path ~= nil then
                        py_path = venv_path .. "/bin/python3"
                    else
                        py_path = vim.g.python3_host_prog
                    end
                    require('lspconfig').pylsp.setup({
                        settings = {
                            pylsp = {
                                plugins = {
                                    -- formatter options: see by conform.nvim
                                    black = { enabled = false },
                                    autopep8 = { enabled = false },
                                    yapf = { enabled = false },
                                    -- linter options
                                    pylint = { enabled = true, executable = "pylint" },
                                    pyflakes = { enabled = false },
                                    pycodestyle = { enabled = false },
                                    -- type checker
                                    pylsp_mypy = {
                                        enabled = true,
                                        overrides = { "--python-executable", py_path, true },
                                        report_progress = true,
                                        live_mode = false
                                    },
                                    -- auto-completion options
                                    jedi_completion = { fuzzy = true },
                                    -- import sorting
                                    pyls_isort = { enabled = false },
                                },
                            },
                        },
                    })
                end,
            }
        })
    end,
}
