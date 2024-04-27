vim.g.mapleader = " "
local keymap = vim.keymap
-- show file explorer
keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- clear search
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- copy things from vim to my system
keymap.set("n", "<leader>y", "\"+ y")
keymap.set("v", "<leader>y", "\"+ y")
keymap.set("n", "<leader>y", "\"+ Y")

-- select and move highlight lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- copy for external
keymap.set("n", "<leader>y", "\"+y")
keymap.set("v", "<leader>y", "\"+y")
keymap.set("n", "<leader>d", "\"_d")
keymap.set("v", "<leader>d", "\"_d")
-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
