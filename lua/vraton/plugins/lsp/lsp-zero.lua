return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        { 'williamboman/mason.nvim' },

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
            vim.keymap.set("n", "<leader>vh", function() vim.lsp.buf.hover() end, opts)
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

        local mason_lspconfig = require("mason-lspconfig")

        lsp_zero.on_attach(on_attach)
        lsp_zero.buffer_autoformat()
        -- import mason
        local mason = require("mason")
        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

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
                "pyright",
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
                    require('lspconfig').pyright.setup({
                        disableOrganizeImports = true,
                        settings = {
                            python = {
                                venvPath = py_path,
                            },
                        },
                    })
                end,
            }
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "isort", -- python formatter
                "black", -- python formatter
                "pylint",
                "eslint_d",
                "goimports"
            },
        })
    end,
}
