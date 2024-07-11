return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gpp", ":G push<CR>", { desc = "Fugitive: git push" })
        vim.keymap.set("n", "<leader>gff", ":G fetch<CR>", { desc = "Fugitive: git fetch" })
        vim.keymap.set("n", "<leader>gll", ":G pull<CR>", { desc = "Fugitive: git pull" })
        vim.keymap.set("n", "<leader>gtt",
            ":G log --oneline --graph --all --decorate --pretty=format:'%C(blue)%h%C(red)%d | %C(white)%s - %C(cyan)%cn, %C(green)%cr'<CR>",
            { desc = "Fugitive: git tree" })
    end
}
