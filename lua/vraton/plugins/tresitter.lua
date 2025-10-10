return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',

    config = function()
        require('nvim-treesitter').install({
            'vim',
            'vimdoc',
            'lua',
            'python',
            'typescript',
            'javascript',
            'css',
            'go',
            'rust',
            "html"
        })
    end
}
