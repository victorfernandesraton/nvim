return {
    "neanias/everforest-nvim",
    -- "rose-pine/neovim",
    -- "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        local everforest = require("everforest")
        everforest.setup({
            background = "hard",
            transparent_background_level = 1,
            italics = false,
            disable_italic_comments = false,
            dim_inactive_windows = true
        })
        -- require("rose-pine").setup({
        --     dim_inactive_windows = true,
        --     extend_background_behind_borders = true,
        --     enable = {
        --         terminal = false,
        --         legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
        --         migrations = true,        -- Handle deprecated options automatically
        --     },
        --
        --     styles = {
        --         bold = true,
        --         italic = false,
        --         transparency = true,
        --     },
        --     highlight_groups = {
        --         NormalFloat = { bg = "none" },
        --         Normal = { bg = 'none' },
        --         -- Pmenu = {bg = 'none'},
        --         -- FloatBorder = {bg = 'none'}
        --     },
        --
        -- })
        -- vim.cmd("colorscheme gruvbox")
        -- vim.cmd("colorscheme rose-pine")
        -- vim.cmd("colorscheme everforest")
        everforest.load()
        -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
        -- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
        -- vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
    end
}
