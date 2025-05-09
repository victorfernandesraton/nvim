return {

    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason-lspconfig.nvim" },
        { "rafamadriz/friendly-snippets" },
        { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
        -- my shotcuts
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Goto definition" })
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "Goto implementation" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "LSP hover" })
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
                    vim.keymap.set('n', '<leader>==', function() vim.lsp.buf.format({bufnr = args.buf, id= client.id}) end, { desc = "AutoFormat with lsp" })
                end
            end,
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            auto_start = true,
            -- list of servers for mason to install
            ensure_installed = {
                "rust_analyzer",
                "ts_ls",
                "denols",
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "emmet_ls",
                "ruff",
                "pyright",
                "gopls",
                'sqlls',
                'bashls',
                'marksman',
                "elixirls",
                "intelephense",
                "eslint",
            },
            handlers = {
                function(server_name)
                    vim.lsp.config(server_name, {})
                end,
                -- this is the "custom handler" for `lua_ls`
                lua_ls = function()
                    vim.lsp.config.lua_ls = {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim' }
                                }
                            }
                        },
                    }
                end,
                gopls = function()
                    vim.lsp.config.gopls= {
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
                    }
                end,
                denols = function()
                    vim.lsp.config.denols = {
                        capabilities = capabilities,
                        root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
                        init_options = {
                            lint = true
                        }
                    }
                end,
                ts_ls = function()
                    vim.lsp.config.ts_ls = {
                        capabilities = capabilities,
                        root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "package.json", "yarn.lock",
                            "lerna.json", "pnpm-lock.yaml", "pnpm-workspace.yaml"),
                        single_file_support = false
                    }
                end
            }
        })

    end,
}
