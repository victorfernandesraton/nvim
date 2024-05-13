return {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    config = function()
        require("codesnap").setup({
            watermark = "",
            breadcrumbs_separator = "/",
            has_breadcrumbs = false,
            has_line_number = false,
            min_width = 0,
            code_font_family = "MesloLGS NF",

        })

        vim.keymap.set("n", "<leader>vc", ":CarbonNow<CR>", { desc = "Carbon all file" })
        vim.keymap.set("v", "<leader>vc", "' :CarbonNow<CR>", { desc = "Carbon selected file" })
    end,
    keys = {
        { "<leader>cc", "<cmd>CodeSnap<cr>",     mode = "x", desc = "Save selected code snapshot into clipboard" },
        { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
}
