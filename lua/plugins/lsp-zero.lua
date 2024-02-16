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
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set('n', '<leader>=', function() vim.lsp.buf.format { async = true } end, opts)
            lsp_zero.buffer_autoformat()
            if client.name == 'ruff_lsp' then
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false
            end
        end)

        lsp_zero.on_attach(on_attach)
        -- to learn how to use mason.nvim with lsp-zero
        -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md

        require('mason').setup({})
        require('mason-tool-installer').setup({
            -- Install these linters, formatters, debuggers automatically
            ensure_installed = {
                'ruff',
                'debugpy',
                'mypy',
            },
        })
        require('mason-lspconfig').setup({
            ensure_installed = { 'tsserver', 'rust_analyzer', 'pyright', 'eslint', 'gopls', 'ruff_lsp', },
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
                ruff_lsp = function()
                    require('lspconfig').ruff_lsp.setup {
                        on_attach = on_attach,
                        default_config = {
                            cmd = { 'ruff-lsp' },
                            filetypes = { 'python' },
                            root_dir = require('lspconfig').util.find_git_ancestor,
                            init_options = {
                                settings = {
                                    args = {}
                                }
                            }
                        }
                    }
                end,
                pyright = function()
                    require('lspconfig').pyright.setup {
                        on_attach = on_attach,
                        settings = {
                            pyright = {
                                -- Using Ruff's import organizer
                                disableOrganizeImports = true,
                            },
                            python = {
                                analysis = {
                                    -- Ignore all files for analysis to exclusively use Ruff for linting
                                    ignore = { '*' },
                                },
                            },
                        },
                    }
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
                timeout_ms = 10000,
            },
            servers = {
                ['tsserver']      = { 'javascript', 'typescript' },
                ['rust_analyzer'] = { 'rust' },
                ['gofmt']         = { 'go', 'golang' },
                ['ruff']          = { 'python' }
            }
        })
    end
}
