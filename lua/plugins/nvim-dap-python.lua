return {
    -- https://github.com/mfussenegger/nvim-dap-python
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
        -- https://github.com/mfussenegger/nvim-dap
        'mfussenegger/nvim-dap',
    },
    lazy = true,
    keys = {
        { "<leader>dpt", function() require('dap-python').test_method() end, desc = "Debug Method" },
        { "<leader>dpc", function() require('dap-python').test_class() end,  desc = "Debug Class" },
    },
    config = function()
        table.insert(require('dap').configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Run handler.py RPA',
            program = 'handler.py',
        })
    end
}
