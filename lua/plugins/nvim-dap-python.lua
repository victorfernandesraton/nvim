return {
    {
        "mfussenegger/nvim-dap",
        optional = true,
        dependencies = {
            "mfussenegger/nvim-dap-python",
            -- stylua: ignore
            keys = {
                { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method" },
                { "<leader>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class" },
            },
            config = function()
                local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
                require('dap-python').setup(mason_path .. "packages/debugpy/venv/bin/python")
            end,
        },
    },
}
