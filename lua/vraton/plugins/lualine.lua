return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function getautofmt()
            local text = "fmt"
            if vim.g.disable_autoformat then
                text = text .. " g:off"
            else
                text = text .. " g:on"
            end

            if vim.b.disable_autoformat then
                text = text .. " b:off"
            else
                text = text .. " b:on"
            end
            return text
        end
        require('lualine').setup({
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { getautofmt },
                lualine_z = { "location", "progress" },
            },
        })
    end
}
