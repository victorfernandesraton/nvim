return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                go = { "goimports", "gofmt" },
                lua = { "stylua" },
                python = { "ruff_fix", "ruff_format" },
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
