return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                "elixir",
                "heex",
                "eex",
                'vim',
                'vimdoc',
                'lua',
                'python',
                'typescript',
                'javascript',
                'css',
                'go',
                "html"
            },

            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        }
    end
}
