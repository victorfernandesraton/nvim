return {
    "ellisonleao/carbon-now.nvim",
    lazy = true,
    cmd = "CarbonNow",
    config = function()
        local carbon = require('carbon-now')
        carbon.setup({
            options = {

                { theme = "Night Owl", font_family = "JetBrains Mono" }

            }
        })
        vim.keymap.set("v", "<leader>nC", "<cmd>CarbonNow<CR>", { silent = true, desc = "CarbonNow shotscreen" })
    end
}
