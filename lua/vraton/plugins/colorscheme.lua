return {
    "neanias/everforest-nvim",
    -- "rose-pine/neovim",
    -- "ellisonleao/gruvbox.nvim",
    priority = 1000,
    version = false,
    lazy = false,
    config = function()
        local everforest = require("everforest")

        everforest.setup({
            background = "hard",
            transparent_background_level = 1,
            italics = false,
            disable_italic_comments = false,
            diagnostic_text_highlight = false,
            dim_inactive_windows = false,
            inlay_hints_background = "none",
            spell_foreground = true
        })
        everforest.load()
        -- require("rose-pine").setup({
        --     dim_inactive_windows = false,
        --     extend_background_behind_borders = false,
        --     enable = {
        --         terminal = false,
        --         legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        --         migrations = true,        -- Handle deprecated options automatically
        --     },
        --
        --     styles = {
        --         bold = true,
        --         italic = false,
        --         transparency = true,
        --     }
        -- })
        -- vim.cmd("colorscheme rose-pine")
        -- require("gruvbox").setup({
        --     terminal_colors = true, -- add neovim terminal colors
        --     undercurl = true,
        --     underline = true,
        --     bold = true,
        --     strikethrough = false,
        --     invert_selection = true,
        --     invert_signs = false,
        --     invert_tabline = true,
        --     inverse = true, -- invert background for search, diffs, statuslines and errors
        --     -- contrast = "hard", -- can be "hard", "soft" or empty string
        --     palette_overrides = {},
        --     overrides = {},
        --     dim_inactive = false,
        --     transparent_mode = true,
        --
        -- })
        -- vim.cmd("colorscheme gruvbox")
        -- return {}
    end
}
