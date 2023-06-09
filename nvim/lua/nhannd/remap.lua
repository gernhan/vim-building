vim.g.mapleader = " "
vim.keymap.set("n", "<leader>wd", ":q<cr>", { desc = "Close tab/window" })
vim.keymap.set("n", "<leader>ww", "<c-w>p", { desc = "Back to last tab/window" })

vim.keymap.set("n", "<leader>ss", ":w<cr>")
vim.keymap.set("n", "<leader>lso", ":w<cr>:so<cr>:source ~/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader>lsp", ":w<cr>:so<cr>:PackerSync<cr>:source ~/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader>lsi", ":w<cr>:so<cr>:PackerInstall<cr>:source ~/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader>lll", ":source ~/.config/nvim/init.lua<cr>")

vim.keymap.set("n", "<leader>bb", ":b#<cr>")
vim.keymap.set("n", "<leader>bd", ":Bdelete<cr>")
vim.keymap.set("n", "<leader>qq", ":qa<cr>", {})

vim.keymap.set({ "n", "v" }, "mu", "4k")
vim.keymap.set("n", "mmu", "<c-u>")
vim.keymap.set({ "n", "v" }, "md", "4j")
vim.keymap.set("n", "mmd", "<c-d>")
vim.keymap.set("n", "mb", "<c-o>", { desc = "Move back" })
vim.keymap.set("n", "mf", "<c-i>", { desc = "Move forward" })

local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
-- local keymap = function (mode, shortcut, command, opts)
--   local custom_opts = default_opts
--   for k,v in pairs(opts)
--     do custom_opts[k] = v
--   end
--   vim.api.nvim_set_keymap(mode, shortcut, command, custom_opts)
-- end
local keymap = vim.api.nvim_set_keymap

keymap("n", "<c-a>", "ggVG", default_opts)
keymap("n", "<c-n>", ":tabnew<cr>", default_opts)

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
keymap("i", "jj", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

vim.keymap.set("n", "<leader>rep", function()
  return ":<c-u>" .. "%s/".. "<C-r>\"" .."//"
end, { expr = true })

vim.keymap.set("v", "<leader>rep", function()
  return "y:" .. "let @/=escape(@\", '/\')<cr>" .. ":%s/\\(".. "<C-r>/" .."\\)/\\1"
end, { expr = true })

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Switch buffer
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", default_opts)
vim.keymap.set("n", "<S-l>", ":bnext<CR>", default_opts)

vim.keymap.set({ "n", "t" }, "<S-l>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

keymap("n", "<leader>sv", ":vsplit<CR>", default_opts)
keymap("n", "<leader>sh", ":split<CR>", default_opts)

vim.keymap.set("t", "<leader><Esc>", "<c-\\><c-n>", default_opts)
keymap("n", "<leader>tt", ":terminal<CR>", default_opts)
keymap("t", "<leader>tx", "<c-\\><c-n>:bd!<cr>", default_opts)
keymap("t", "<leader>kkk", "<c-\\><c-n>:bd!<cr>", default_opts)
keymap("n", "<leader>kkk", ":bd!<cr>", default_opts)
vim.keymap.set("n", "<leader>it", function()
  return ":e " .. vim.fn.expand("%:p:h") .. "/"
end, { expr = true })
