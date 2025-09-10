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
        local function getLsps()
            local clients = vim.lsp.get_clients()
            if #clients == 0 then
                return "No LSP"
            end

            local client_names = {}
            for _, client in ipairs(clients) do
                local name = client.name
                if name then
                    table.insert(client_names, name)
                end
            end

            return table.concat(client_names, ", ")
        end
        require('lualine').setup({
            sections = {
                lualine_a = { 'filename' },
                lualine_b = { 'diagnostics' },
                lualine_c = {  },
                lualine_x = { 'encoding', 'filetype' },
                lualine_y = { "location" },
                lualine_z = { "progress" },
            },
            tabline = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', "diff" },
                lualine_c = {getLsps},
                lualine_x = {},
                lualine_y = { getrelativelines },
                lualine_z = {}
            }
        })
    end
}
