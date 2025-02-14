return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        {
            '<leader>=f',
            function()
                -- If autoformat is currently disabled for this buffer,
                -- then enable it, otherwise disable it
                if vim.b.disable_autoformat then
                    vim.cmd 'FormatEnable'
                    vim.notify 'Enabled autoformat for current buffer'
                else
                    vim.cmd 'FormatDisable!'
                    vim.notify 'Disabled autoformat for current buffer'
                end
            end,
            desc = 'Toggle autoformat for current buffer',
        },
        {
            '<leader>=F',
            function()
                -- If autoformat is currently disabled globally,
                -- then enable it globally, otherwise disable it globally
                if vim.g.disable_autoformat then
                    vim.cmd 'FormatEnable'
                    vim.notify 'Enabled autoformat globally'
                else
                    vim.cmd 'FormatDisable'
                    vim.notify 'Disabled autoformat globally'
                end
            end,
            desc = 'Toggle autoformat globally',
        },
    },
    config = function()
        local conform = require("conform")
        toggle_format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            local disable_filetypes = { c = false, cpp = false }
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
        end
        conform.setup({
            formatters_by_ft = {
                go = { "goimports", "gofmt" },
                lua = { "stylua" },
                python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
                elixir = { "elixirls" },
                javascript = { "standardjs", "denolsp" },
                typescript = { "standardjs", "denolsp" },
                javascriptreact = { "standardjs", "denolsp" },
                typescriptreact = { "standardjs", "denolsp" },
                php = { "phpcbf" }
            },
            format_on_save = toggle_format_on_save,
            format_after_save = toggle_format_on_save,
            formatters = {
                ruff_organize_imports = {
                    command = 'ruff',
                    args = {
                        'check',
                        '--force-exclude',
                        '--select=I001',
                        '--fix',
                        '--exit-zero',
                        '--stdin-filename',
                        '$FILENAME',
                        '-',
                    },
                    stdin = true,
                    cwd = require('conform.util').root_file {
                        'pyproject.toml',
                        'ruff.toml',
                        '.ruff.toml',
                    },
                },
            }
        })

        vim.api.nvim_create_user_command('FormatDisable', function(args)
            if args.bang then
                -- :FormatDisable! disables autoformat for this buffer only
                vim.b.disable_autoformat = true
            else
                -- :FormatDisable disables autoformat globally
                vim.g.disable_autoformat = true
            end
        end, {
            desc = 'Disable autoformat-on-save',
            bang = true, -- allows the ! variant
        })

        vim.api.nvim_create_user_command('FormatEnable', function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = 'Re-enable autoformat-on-save',
        })

        vim.keymap.set({ "n", "v" }, "<leader>==", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
