return {
    'akinsho/toggleterm.nvim',
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<c-t>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
            direction = 'horizontal',
        })
    end
}
