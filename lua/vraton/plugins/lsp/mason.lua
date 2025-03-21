return {

    'williamboman/mason.nvim',
    dependencies = {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_tool_installer = require("mason-tool-installer")
        -- enable mason and configure icons
        mason.setup({
            ensure_installed = {
            }
        })
        mason_tool_installer.setup({
            ensure_installed = {
                "ruff",
                "goimports",
                "golines",
                "golangci-lint",
                "mypy",
                "phpcbf",
                "phpstan",
                "eslint_d"
            },
        })
    end
}
