return {
    "michaelPotter/iron.nvim",
    config = function()
        local iron = require("iron.core")
        local common = require("iron.fts.common")

        iron.setup({
            config = {
                -- Whether a repl should be discarded or not
                scratch_repl = true,
                -- Your repl definitions come here
                repl_definition = {
                    sh = {
                        -- Can be a table or a function that
                        -- returns a table (see below)
                        command = { "zsh" },
                    },
                },
                -- How the repl window will be displayed
                -- See below for more information
                repl_open_cmd = require("iron.view").split.vertical("50%"),
                python = {
                    command = { "uv run python" },  -- or { "ipython", "--no-autoindent" }
                    format = common.bracketed_paste_python,
                    block_dividers = { "# %%", "#%%" },
                }

            },
            -- Iron doesn't set keymaps by default anymore.
            -- You can set them here or manually add keymaps to the functions in iron.core
            keymaps = {
                send_motion = "<space>sc",
                visual_send = "<space>sc",
                send_file = "<space>sf",
                send_line = "<space>sl",
                send_code_block = "<space>sB",
                send_code_block_and_move = "<space>sn",
                send_mark = "<space>sm",
                mark_motion = "<space>mc",
                mark_visual = "<space>mc",
                remove_mark = "<space>md",
                cr = "<space>s<cr>",
                interrupt = "<space>s<space>",
                exit = "<space>sq",
                clear = "<space>cl",
            },

            dap_integration = true,
            -- If the highlight is on, you can change how it looks
            -- For the available options, check nvim_set_hl
            --
            highlight = {
                italic = true,
            },
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        })


        -- iron also has a list of commands, see :h iron-commands for all available commands
        vim.keymap.set("n", "<space>sr", "<cmd>IronRepl<cr>")
        vim.keymap.set("n", "<space>sR", "<cmd>IronRestart<cr>")
        vim.keymap.set("n", "<space>sf", "<cmd>IronFocus<cr>")
        vim.keymap.set("n", "<space>sH", "<cmd>IronHide<cr>")
    end,
}
