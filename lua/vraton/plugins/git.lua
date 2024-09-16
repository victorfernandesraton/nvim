return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local gitsigns = require('gitsigns')

            gitsigns.setup()
            vim.keymap.set('n', '<leader>gT', gitsigns.toggle_current_line_blame)
            vim.keymap.set('n', '<leader>gP', gitsigns.preview_hunk)
        end
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
            vim.keymap.set("n", "<leader>gpp", ":G push<CR>", { desc = "Fugitive: git push" })
            vim.keymap.set("n", "<leader>gff", ":G fetch<CR>", { desc = "Fugitive: git fetch" })
            vim.keymap.set("n", "<leader>gll", ":G pull<CR>", { desc = "Fugitive: git pull" })
            vim.keymap.set("n", "<leader>gtt", ":GcLog<CR>", { desc = "Fugitive: view git grapth" })
        end
    },
}
