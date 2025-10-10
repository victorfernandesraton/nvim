return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        'williamboman/mason.nvim',
    },
    lazy = false,
    build= ":MasonUpdate",
    config = function()
        local mason_tool_installer = require("mason-tool-installer")
        mason_tool_installer.setup({
            ensure_installed = {
                "ruff",
                "goimports",
                "golines",
                "phpcbf",
            },
        })

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = {
                'denols',
                "ts_ls",
                "html",
                "cssls",
                "lua_ls",
                "ruff",
                "pylsp",
                "gopls",
                'marksman',
                'sqls',
                'bashls',
                "eslint",
                "vue_ls",
                "jsonls",
                "ltex"
            }
        })
    end
}
