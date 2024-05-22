return {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
        { "<leader>cc", ":CodeSnap<CR>",     mode = "x", desc = "Save selected code snapshot into clipboard" },
        { "<leader>cs", ":CodeSnapSave<CR>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
    config = function()
        require("codesnap").setup({
            save_path = "~/Pictures",
            has_breadcrumbs = true,
            watermark = "",
            bg_color = "#535c68",
            title = "vraton.dev from CodeSnap.nvim",
        })
    end
}
