return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function getrelativelines()
            if vim.wo.relativenumber then
                return "rln:on"
            else
                return "rln:off"
            end
        end
        require('lualine').setup({
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'filename', 'diagnostics', 'diff'},
                lualine_c = { 'branch',  },
                lualine_x = { 'encoding', 'filetype' },
                lualine_y = {getrelativelines },
                lualine_z = { "location", "progress"},
            },
        })
    end
}
