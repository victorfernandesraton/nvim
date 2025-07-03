local opt = vim.opt
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.undofile = true

opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true

opt.nu = true
opt.relativenumber = true
opt.scrolloff = 4
opt.colorcolumn = "80"
opt.updatetime = 50
opt.signcolumn = "yes"


opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
-- patch for ntre
vim.g.netrw_liststyle  = 3
