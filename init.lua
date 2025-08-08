vim.g.mapleader = " "
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.undofile = true

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.nu = true
vim.o.relativenumber = true
vim.o.scrolloff = 4
vim.o.colorcolumn = "80"
vim.o.updatetime = 50
vim.o.signcolumn = "yes"


vim.o.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.o.termguicolors = true
vim.o.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.o.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- split windows
vim.o.splitright = true -- split vertical window to the right
vim.o.splitbelow = true -- split horizontal window to the bottom
vim.o.winborder = "rounded"

-- turn off swapfile
vim.o.swapfile = false
-- patch for ntre
vim.g.netrw_keepdir = 1
-- vim.g.netrw_liststyle  = 3

require("vraton.lazy")

local keymap = vim.keymap
-- clear search
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Reser search markup when go to nomral mode and press esc" })

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
keymap.set("n", "<C-c>", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Toggle between relative and absolute line numbers
keymap.set('n', '<leader>ln', ':lua ToggleLineNumbers()<CR>', { noremap = true, silent = true })

keymap.set('n', '<leader>q', ':quit<CR>', { noremap = true, silent = true })

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

keymap.set("n", "<leader>o", ":update<CR> :source<CR>", {desc = "Refresh"})

keymap.set("n", "<leader>ee", "<CMD>Oil<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer

-- keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
-- keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })   -- refresh file explorer
