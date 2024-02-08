return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { 'vim', 'vimdoc', 'lua', 'python' },

            auto_install = false,

            highlight = { enable = true },

            indent = { enable = true },

        }
    end
}
