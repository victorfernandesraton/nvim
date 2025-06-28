vim.g.mapleader = " "
local keymap = vim.keymap
-- clear search
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {desc = "Reser search markup when go to nomral mode and press esc"})

-- copy things from vim to my system
keymap.set("n", "<leader>y", "\"+ y")
keymap.set("v", "<leader>y", "\"+ y")
keymap.set("n", "<leader>y", "\"+ Y")

-- select and move highlight lines
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "J", ":m '>+1<CR>gv=gv")

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

-- Toggle between relative and absolute line numbers
keymap.set('n', '<leader>ln', ':lua ToggleLineNumbers()<CR>', { noremap = true, silent = true })

-- Define the function to toggle line numbers
function ToggleLineNumbers()
    if vim.wo.relativenumber then
        vim.wo.relativenumber = false
        vim.wo.number = true
    else
        vim.wo.relativenumber = true
        vim.wo.number = true
    end
end

-- Shortcut to reload all Lua configuration
keymap.set('n', '<leader>rl', ':luafile $MYVIMRC<CR>', { noremap = true, silent = true })

