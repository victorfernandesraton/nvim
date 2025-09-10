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
                lualine_a = { 'filename' },
                lualine_b = { 'diagnostics' },
                lualine_c = {},
                lualine_x = { 'encoding', 'filetype' },
                lualine_y = { "location" },
                lualine_z = { "progress" },
            },
            tabline = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' , "diff"},
                lualine_x = {},
                lualine_y = { getrelativelines },
                lualine_z = {}
            }
        })
    end
}
