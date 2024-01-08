vim.opt.cursorline = true
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

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

vim.env.JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
vim.env.JAVA_TOOL_OPTIONS =
"-javaagent:" .. vim.fn.expand("$HOME") .. "/.m2/repository/org/projectlombok/lombok/1.18.26/lombok-1.18.26.jar"

vim.g.jdtls_workspace = {
  data = vim.fn.expand("~/jdtls_data"),
}

-- Set JDTLS configuration variables
vim.g.jdtls_launcher_args =
{ "-configuration", "~/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac" }
vim.api.nvim_set_option('wildcharm', string.byte('\r'))
