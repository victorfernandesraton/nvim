return {

    'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function(_, opts)
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fg', function()
                    bultin.grep_string({search = vim.fn.input('Grep > ')});
            end)
        end,
    }
