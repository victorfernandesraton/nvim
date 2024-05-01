return {
    "rose-pine/nvim",
    name = "rose-pine",
    priority = 1000,
    config = function()
        require('rose-pine').setup({
            disable_background = false,
        })
        local color = "rose-pine"
        vim.cmd.colorscheme(color)
        ColorMyPencils()
    end
}
