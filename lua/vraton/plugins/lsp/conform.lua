return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

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
            format_on_save = {
                lsp_format = "fallback",
                timeout_ms = 1000,
            },
            format_after_save = {
                lsp_format = "fallback",
                async = true,
            },
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

        vim.keymap.set({ "n", "v" }, "<leader>=", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
