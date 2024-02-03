return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = false,
    lazy = false,
    dependencies = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {"hrsh7th/cmp-nvim-lsp"},
        {"hrsh7th/cmp-buffer"},
        {"hrsh7th/cmp-path"},
        {"hrsh7th/nvim-cmp"},
        {"hrsh7th/cmp-nvim-lua"},
        {"saadparwaiz1/cmp_luasnip"},
        {"rafamadriz/friendly-snippets"},
        {'neovim/nvim-lspconfig',
            dependencies = {
                {'hrsh7th/cmp-nvim-lsp'},
            }
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                {'L3MON4D3/LuaSnip'}
            },
        },
    },
}
