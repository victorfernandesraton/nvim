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
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename', },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_z = { "location", "progress", getrelativelines },
            },
        })
    end
}
