return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "telescope find files" })
        vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = "telescope git files" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "telescope grep" })
    end,
}
