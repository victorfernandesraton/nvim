return {
    "AckslD/swenv.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require('swenv').setup({})
    end
}
