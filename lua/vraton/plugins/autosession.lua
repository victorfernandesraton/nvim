return {
    "rmagatti/auto-session",
    keys = {
        -- Will use Telescope if installed or a vim.ui.select picker otherwise
        { '<leader>wr', '<cmd>SessionSearch<CR>',  desc = 'Session search' },
        { '<leader>ws', '<cmd>SessionSave<CR>',    desc = 'Save session' },
        { '<leader>wo', '<cmd>SessionRestore<CR>', desc = 'Restore session' },
    },
    opts = {
        auto_restore = false,
        suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" }
    }
}
