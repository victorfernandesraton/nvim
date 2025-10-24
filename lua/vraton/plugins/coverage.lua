return {
    "andythigpen/nvim-coverage",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require("coverage").setup({
            auto_reload = true,
            lang = {
                javascript = {
                    coverage_file = "lcov.info"
                }
            }
        })
    end,
    keys = {
        { "<leader>tC", ":CoverageSummary<CR>",mode = "n", desc = "Show coverage summary" },
        { "<leader>tc", ":CoverageToggle<CR>", mode = "n", desc = "Toggle coverage in current file" },
    },
}
