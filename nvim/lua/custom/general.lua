vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

-- vim.opt.softtabstop = 2
-- Set indentation settings
vim.o.expandtab = true -- Use spaces instead of <Tab>
vim.o.shiftwidth = 2   -- Set the number of spaces per indent
vim.o.tabstop = 2      -- Set the number of spaces for <Tab> key

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
vim.opt.updatetime = 250

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.api.nvim_set_option("wildcharm", string.byte("\r"))
