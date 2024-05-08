return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { 'vim', 'vimdoc', 'lua', 'python', 'typescript', 'javascript', 'css', 'go' },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        }
    end
}
