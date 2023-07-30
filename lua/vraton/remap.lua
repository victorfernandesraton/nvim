vim.g.mapleader = " "
-- show file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pb", ":Neotree toggle<CR>")
 
-- copy things from vim to my system
vim.keymap.set("n", "<leader>y",  "\"+ y")
vim.keymap.set("v", "<leader>y",  "\"+ y")
vim.keymap.set("n", "<leader>y",  "\"+ Y")

-- select and move highlight lines 
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- copy for external
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
