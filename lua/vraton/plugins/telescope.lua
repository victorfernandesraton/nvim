return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local transform_mod = require("telescope.actions.mt").transform_mod

        local trouble = require("trouble")
        local trouble_telescope = require("trouble.sources.telescope")

        -- or create your custom action
        local custom_actions = transform_mod({
            open_trouble_qflist = function(_)
                trouble.toggle("quickfix")
            end,
        })

        telescope.setup({
            defaults = {
                preview = {
                    treesitter = false,
                },
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<C-q>"] = actions.send_to_qflist + custom_actions.open_trouble_qflist,
                        ["<C-p>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
                        ["<C-t>"] = trouble_telescope.open,
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        local builtin = require('telescope.builtin')
        keymap.set("n", "<leader>fT", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
        keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
        keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })
        keymap.set('n', '<leader>ff', function()
            builtin.live_grep({ additional_args = { '-u' } })
        end, { desc = 'Telescope live grep (ALL)' })
        keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope old files' })
        keymap.set('n', '<leader>fp', function()
            builtin.find_files({ no_ignore=true , hidden=true})
        end, { desc = 'Telescope find files (ALL)' })
        keymap.set('n', '<leader>fm', builtin.reloader, { desc = 'Telescope lua modules' })
        keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Telescope grep string' })
        keymap.set('n', '<leader>ft', builtin.treesitter, { desc = 'Telescope treesitter' })
        keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = '[S]earch [B]uffer' })
        keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
        keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'Git stash' })
    end,
}
