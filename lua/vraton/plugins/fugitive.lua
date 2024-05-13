return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gpp", ":G push<CR>")
        vim.keymap.set("n", "<leader>gff", ":G fetch<CR>")
        vim.keymap.set("n", "<leader>gll", ":G pull<CR>")
        vim.keymap.set("n", "<leader>gtt",
            ":G log --oneline --graph --all --decorate --pretty=format:'%C(blue)%h%C(red)%d | %C(white)%s - %C(cyan)%cn, %C(green)%cr'<CR>",
            { desc = "Fugitive: git tree" })
    end
}
