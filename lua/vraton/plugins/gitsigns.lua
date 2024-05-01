return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require('gitsigns')

        gitsigns.setup()
        vim.keymap.set('n', '<leader>gT', gitsigns.toggle_current_line_blame)
        vim.keymap.set('n', '<leader>gP', gitsigns.preview_hunk)
    end

}
