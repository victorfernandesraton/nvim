local result = {
    "mistricky/codesnap.nvim",
    event = "VeryLazy",
    build = "make build_generator",
    keys = {
        { "<leader>cc", ":CodeSnap<CR>",     mode = "x", desc = "Save selected code snapshot into clipboard" },
        { "<leader>cs", ":CodeSnapSave<CR>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
    config = function()
        require("codesnap").setup({
            save_path = "~/Pictures",
            has_breadcrumbs = false,
            has_line_number = true,
            show_workspace = false,
            watermark = "",
            bg_color = "#535c68",
            title = "vraton.dev from CodeSnap.nvim",

        })
    end
}

if vim.fn.has("win32") == 1 then
    result = {}
end

return result
