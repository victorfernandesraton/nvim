-- Debugging Support
return {
    -- https://github.com/rcarriga/nvim-dap-ui
    'rcarriga/nvim-dap-ui',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- https://github.com/mfussenegger/nvim-dap
        'mfussenegger/nvim-dap',

        { "williamboman/mason.nvim", opts = { PATH = "append" } },
        -- https://github.com/theHamsta/nvim-dap-virtual-text
        'theHamsta/nvim-dap-virtual-text',   -- inline variable text while debugging
        -- https://github.com/nvim-telescope/telescope-dap.nvim
        'nvim-telescope/telescope-dap.nvim', -- telescope integration with dap
        "jay-babu/mason-nvim-dap.nvim",
        -- golang
        "leoluz/nvim-dap-go",
        -- python
        'mfussenegger/nvim-dap-python',
        "linux-cultist/venv-selector.nvim",
        -- js
        "mxsdev/nvim-dap-vscode-js",
        {
            'Joakker/lua-json5',
            build = './install.sh'
        }
    },
    opts = {
        controls = {
            element = "repl",
            enabled = true,
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
                    { id = "scopes", size = 0.25 },
                    "breakpoints",
                    "stacks",
                    "watches",
                },
                size = 40, -- 40 columns
                position = "left",
            },
            {
                elements = {
                    "console",
                    "repl",
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
        local dapui = require('dapui')
        local python_path = require("venv-selector").python()
        require('dap-go').setup({
            external_config = {
                enabled = true,
            }
        })

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,


            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {
                function(config)
                    -- all sources with no handler get passed here
                    -- Keep original functionality
                    require('mason-nvim-dap').default_setup(config)
                end,
            },



            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'python',
                'php',
                'node',
            },
        }

        table.insert(require('dap').configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Run current file (with env)',
            program = '${file}',
            console = "integratedTerminal",
            cwd = python_path
        })

        table.insert(require('dap').configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Run handler.py RPA',
            program = 'handler.py',
            console = "integratedTerminal",
            pythonPath = python_path
        })

        table.insert(require('dap').configurations.python, {
            name = "Pytest: Current File",
            type = "python",
            request = "launch",
            module = "pytest",
            args = {
                "${file}",
            },
            pythonPath = python_path,
            console = "integratedTerminal",
        })
        table.insert(require('dap').configurations.python, {
            name = "Pytest: Querido diário spyder",
            type = "python",
            request = "launch",
            module = "scrapy",
            args = {
                "crawl",
                "${fileBasenameNoExtension}",
            },
            cwd = "${workspaceFolder}/data_collection",
            pythonPath = python_path,
            console = "integratedTerminal",
        })

        dap.adapters.debugpy = dap.adapters.python


        local keymap = vim.keymap
        -- dap keybinds
        keymap.set("n", "<leader>bb", function() dap.toggle_breakpoint() end, { desc = "DAP toggle breakpoint" })
        keymap.set("n", "<leader>bc", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
            { desc = "DAP set breakpoint" })
        keymap.set("n", "<leader>bl", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        keymap.set("n", '<leader>br', function() dap.clear_breakpoints() end, { desc = "DAP clear all breakpoints" })
        keymap.set("n", "<F5>", function() dap.continue() end, { desc = "DAP continue" })

        keymap.set("n", "<leader>dt", function() dapui.toggle() end, { desc = "DAP toggle" })

        keymap.set("n", "<leader>dR", function() dap.restart() end, { desc = "DAP restart" })
        keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', { desc = "DAP list breakpoint" })
        keymap.set("n", "<F6>", function() dap.step_over() end, { desc = "DAP step over" })
        keymap.set("n", "<F7>", function() dap.step_into() end, { desc = "DAP step into" })
        keymap.set("n", "<F8>", function() dap.step_out() end, { desc = "DAP step out" })
        keymap.set("n", '<leader>dd', function()
            dap.disconnect(); dapui.close();
        end, { desc = "DAP disconnect" })
        keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "DAP REPL toggle" })
        keymap.set("n", "<F9>", function() dap.run_last() end, { desc = "DAP run last" })
        keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end, { desc = "DAP ui hoover" })
        keymap.set("n", '<leader>d?',
            function()
                local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
            end)

        keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
        keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
        keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({ default_text = ":E:" }) end)



        dapui.setup(opts)

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.after.event_terminated["dapui_config"] = function()
            -- require('dapui').close()
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
