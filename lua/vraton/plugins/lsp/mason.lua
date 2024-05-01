return {

    'williamboman/mason.nvim',
    dependencies = {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_tool_installer = require("mason-tool-installer")
        -- enable mason and configure icons
        mason.setup({})
        mason_tool_installer.setup({
            ensure_installed = {
                "isort", -- python formatter
                "black", -- python formatter
                "pylint",
                "eslint_d",
                "goimports"
            },
        })
    end
}
