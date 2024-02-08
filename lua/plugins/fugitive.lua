return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gpp", ":G push<CR>")
        vim.keymap.set("n", "<leader>gff", ":G fetch<CR>")
        vim.keymap.set("n", "<leader>gll", ":G pull<CR>")
    end
}
