-- Debugging Support
return {
    -- https://github.com/rcarriga/nvim-dap-ui
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
        -- https://github.com/mfussenegger/nvim-dap
        'mfussenegger/nvim-dap',
        -- https://github.com/theHamsta/nvim-dap-virtual-text
        'theHamsta/nvim-dap-virtual-text',   -- inline variable text while debugging
        -- https://github.com/nvim-telescope/telescope-dap.nvim
        'nvim-telescope/telescope-dap.nvim', -- telescope integration with dap
        "jay-babu/mason-nvim-dap.nvim",
        -- python
        'mfussenegger/nvim-dap-python',
        "nvim-neotest/neotest",
        "nvim-neotest/neotest-python",
        -- golang
        "leoluz/nvim-dap-go",
        "nvim-neotest/neotest-go"
    },
    opts = {
        controls = {
            element = "repl",
            enabled = false,
            icons = {
                disconnect = "",
                pause = "",
                play = "",
                run_last = "",
                step_back = "",
                step_into = "",
                step_out = "",
                step_over = "",
                terminate = ""
            }
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
            border = "single",
            mappings = {
                close = { "q", "<Esc>" }
            }
        },
        force_buffers = true,
        icons = {
            collapsed = ">",
            current_frame = ">",
            expanded = ""
        },
        layouts = {
            {
                elements = {
                    {
                        id = "scopes",
                        size = 0.50
                    },
                    {
                        id = "stacks",
                        size = 0.50
                    },
                },
                size = 40,
                position = "left", -- Can be "left" or "right"
            },
            {
                elements = {
                    "repl",
                    "console",
                },
                size = 10,
                position = "bottom", -- Can be "bottom" or "top"
            }
        },
        mappings = {
            edit = "e",
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            repl = "r",
            toggle = "t"
        },
        render = {
            indent = 1,
            max_value_lines = 100
        }
    },
    config = function(_, opts)
        local dap = require('dap')

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'python',
                'delve',
                'debupy'
            },
        }


        require("dap-go").setup()
        require("dap-python").setup()
        table.insert(require('dap').configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Run handler.py RPA',
            program = 'handler.py',
            console = "integratedTerminal",
        })

        table.insert(require('dap').configurations.python, {
            name = "Pytest: Current File",
            type = "python",
            request = "launch",
            module = "pytest",
            args = {
                "${file}",
                "-sv",
                "--no-cov"
            },
            console = "integratedTerminal",
        })

        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    -- Extra arguments for nvim-dap configuration
                    -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                    dap = {
                        justMyCode = false,
                        console = "integratedTerminal",
                    },
                    args = { "--log-level", "DEBUG", "--quiet" },
                    runner = "pytest",
                }),
                require("neotest-go")({})
            }
        })

        local keymap = vim.keymap
        -- dap keybinds
        keymap.set("n", "<leader>bb", function() dap.toggle_breakpoint() end, { desc = "DAP toggle breakpoint" })
        keymap.set("n", "<leader>bc", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
            { desc = "DAP set breakpoint" })
        keymap.set("n", "<leader>bl", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        keymap.set("n", '<leader>br', function() dap.clear_breakpoints() end, { desc = "DAP clear all breakpoints" })
        keymap.set("n", "<F5>", function() dap.continue() end, { desc = "DAP continue" })
        keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', { desc = "DAP list breakpoint" })
        keymap.set("n", "<leader>dj", function() dap.step_over() end, { desc = "DAP step over" })
        keymap.set("n", "<leader>dk", function() dap.step_into() end, { desc = "DAP step into" })
        keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "DAP step out" })
        keymap.set("n", '<leader>dd', function()
            require('dap').disconnect(); require('dapui').close();
        end, { desc = "DAP disconnect" })
        keymap.set("n", '<leader>dt', function()
            require('dap').terminate(); require('dapui').close();
        end, { desc = "DAP terminate" })
        keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "DAP REPL toggle" })
        keymap.set("n", "<leader>dl", function() dap.run_last() end, { desc = "DAP run last" })
        keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end, { desc = "DAP ui hoover" })
        keymap.set("n", '<leader>d?',
            function()
                local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
            end)

        keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
        keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
        keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({ default_text = ":E:" }) end)

        keymap.set("n", "<leader>tm", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Neotest: Test Method" })
        keymap.set("n", "<leader>tM", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
            { desc = "Test Method DAP" })
        keymap.set("n", "<leader>tf", "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
            { desc = "Neotest: Test Class" })
        keymap.set("n", "<leader>tF", "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
            { desc = "Neotest: Test Class DAP" })
        keymap.set("n", "<leader>tS", "<cmd>lua require('neotest').summary.toggle()<cr>", {
            desc =
            "Neotest: Test Summary"
        })


        require('dapui').setup(opts)

        dap.listeners.after.event_initialized["dapui_config"] = function()
            require('dapui').open()
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            -- Commented to prevent DAP UI from closing when unit tests finish
            -- require('dapui').close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            -- Commented to prevent DAP UI from closing when unit tests finish
            -- require('dapui').close()
        end
    end
}
