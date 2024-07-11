return {
    "nvim-neotest/neotest",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-go",
        'nvim-neotest/neotest-jest',
        "fredrikaverpil/neotest-golang", -- Installation

    },
    config = function()
        local keymap = vim.keymap

        local neotest = require("neotest")
        local neotest_ns = vim.api.nvim_create_namespace("neotest")
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message =
                        diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                    return message
                end,
            },
        }, neotest_ns)
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    -- Extra arguments for nvim-dap configuration
                    -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                    dap = {
                        justMyCode = true,
                    },
                    args = { "--log-level", "DEBUG" },
                    runner = "pytest",
                }),
                require("neotest-go"), -- Registration
                require('neotest-jest')({
                    jestCommand = "npm test --",
                    jest_test_discovery = true,
                    env = { CI = true },
                    cwd = function(_)
                        return vim.fn.getcwd()
                    end,
                }),
            }
        })

        keymap.set("n", "<leader>tm", function() neotest.run.run() end, { desc = "Neotest: Test Method" })
        keymap.set("n", "<leader>tM", function() neotest.run.run({ strategy = 'dap' }) end,
            { desc = "Test Method DAP" })
        keymap.set("n", "<leader>tf", function() neotest.run.run({ vim.fn.expand('%') }) end,
            { desc = "Neotest: Test Class" })
        keymap.set("n", "<leader>tF", function() neotest.run.run({ vim.fn.expand('%'), strategy = 'dap' }) end,
            { desc = "Neotest: Test Class DAP" })
        keymap.set("n", "<leader>tS", function() neotest.summary.toggle() end, {
            desc =
            "Neotest: Test Summary"
        })
        keymap.set("n", "<leader>tp", function()
            neotest.output_panel.toggle()
        end)
    end
}
