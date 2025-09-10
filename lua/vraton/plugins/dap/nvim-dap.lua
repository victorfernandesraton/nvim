-- Debugging Support
return {
    -- https://github.com/rcarriga/nvim-dap-ui
    'rcarriga/nvim-dap-ui',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- https://github.com/mfussenegger/nvim-dap
        'mfussenegger/nvim-dap',

        { "williamboman/mason.nvim",      opts = { PATH = "append" } },
        -- https://github.com/theHamsta/nvim-dap-virtual-text
        'theHamsta/nvim-dap-virtual-text',   -- inline variable text while debugging
        -- https://github.com/nvim-telescope/telescope-dap.nvim
        'nvim-telescope/telescope-dap.nvim', -- telescope integration with dap
        "jay-babu/mason-nvim-dap.nvim",
        -- golang
        "leoluz/nvim-dap-go",
        -- python Usando commit pra evitar crashe
        { 'mfussenegger/nvim-dap-python', commit = "eafd6d3b6175b6f7e5ecaadbcf604a1bb7419351" },
        -- js
        "mxsdev/nvim-dap-vscode-js",
        {
            'Joakker/lua-json5',
            build = './install.sh'
        }
    },
    opts = {
        controls = {
            element = "console",
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
        require('dap-go').setup()


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
                'php',
                'node',
                'elixir',
                'python'
            },
        }

        -- table.insert(require('dap').configurations.python, {
        --     name = "Pytest: Current File",
        --     type = "python",
        --     request = "launch",
        --     module = "pytest",
        --     args = {
        --         "${file}",
        --     },
        --     console = "integratedTerminal",
        -- })
        --
        -- table.insert(require('dap').configurations.python, {
        --     name = "Python: Current File",
        --     type = "python",
        --     request = "launch",
        --     program = "${file}",
        --     console = "integratedTerminal",
        -- })
        -- table.insert(require('dap').configurations.python, {
        --     name = "Unittest: Current File",
        --     type = "python",
        --     request = "launch",
        --     module = "unittest",
        --     args = { "${file}" },
        --     console = "integratedTerminal",
        -- })


        -- -- Elixir mix
        -- table.insert(require("dap").configurations.adapters.mix_task, {
        --     type = 'executable',
        --     command = vim.fn.stdpath("data") .. '/mason/bin/elixir-ls-debugger',
        --     args = {}
        -- }
        --
        --
        -- -- Elixir test
        --
        --
        --
        -- table.insert(require("dap").configurations.elixir, {
        --     type = "mix_task",
        --     name = "mix test",
        --     task = 'test',
        --     taskArgs = { "--trace" },
        --     request = "launch",
        --     startApps = true, -- for Phoenix projects
        --     projectDir = "${workspaceFolder}",
        --     requireFiles = {
        --         "test/**/test_helper.exs",
        --         "test/**/*_test.exs"
        --     }
        -- })
        --

        -- hotfix to enable python as a debugpy (VScode compatibility)
        --
        require('dap-python').setup('uv')
        dap.adapters.debugpy = dap.adapters.python
        dap.adapters.node = dap.adapters.node2

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
            -- dapui.open()
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
        local sign = vim.fn.sign_define
        sign('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
    end
}
