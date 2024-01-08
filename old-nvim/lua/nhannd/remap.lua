vim.g.mapleader = " "
vim.keymap.set("n", "<leader>wd", ":q<cr>", { desc = "Close tab/window" })
vim.keymap.set("n", "<leader>ww", "<c-w>p", { desc = "Back to last tab/window" })

vim.keymap.set("n", "<leader>ss", ":w<cr>")
vim.keymap.set("n", "<leader>lso", ":w<cr>:so<cr>:PackerClean<cr>:PackerCompile<cr>:source ~/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader>so", function()
  require "utils.cht".so_input()
  require "utils.dev".reload_modules()
end)
vim.keymap.set("n", "<leader>lsp",
  ":w<cr>:so<cr>:PackerSync<cr>:PackerClean<cr>:source ~/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader>lsi",
  ":w<cr>:so<cr>:PackerInstall<cr>:PackerClean<cr>:PackerCompile<cr>:source ~/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader>lll", ":source ~/.config/nvim/init.lua<cr>")

vim.keymap.set({ "n", "v" }, "mu", "4k", { desc = "Move up" })
vim.keymap.set("n", "mmu", "<c-u>", { desc = "Page up" })
vim.keymap.set("n", "mmk", "<c-u>", { desc = "Page up" })
vim.keymap.set({ "n", "v" }, "mk", "10k", { desc = "Scroll up" })

vim.keymap.set({ "n", "v" }, "md", "4j", { desc = "Move down" })
vim.keymap.set("n", "mmd", "<c-d>", { desc = "Page down" })
vim.keymap.set("n", "mmj", "<c-d>", { desc = "Page down" })
vim.keymap.set({ "n", "v" }, "mj", "10j", { desc = "Scroll down" })

vim.keymap.set("n", "mb", "<c-o>", { desc = "Move back" })
vim.keymap.set("n", "mf", "<c-i>", { desc = "Move forward" })
vim.keymap.set("n", "<leader>nn", ":enew<cr>", { desc = "New File" })

local default_opts = { noremap = true, silent = true }
local function desc(description)
  return { noremap = true, silent = true, desc = description }
end
local expr_opts = { noremap = true, expr = true, silent = true }
-- local keymap = function (mode, shortcut, command, opts)
--   local custom_opts = default_opts
--   for k,v in pairs(opts)
--     do custom_opts[k] = v
--   end
--   vim.api.nvim_set_keymap(mode, shortcut, command, custom_opts)
-- end
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>bb", ":b#<cr>", default_opts)
keymap("n", "<leader>bd", "<Nop>", default_opts)
-- keymap("n", "<leader>bd", ":Bdelete<cr>", default_opts)
keymap("n", "<leader>bd", ":bd<cr>", default_opts)
keymap("n", "<leader>dd", ":Bdelete<cr>", default_opts)
keymap("n", "<leader>qq", ":qa<cr>", {})

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
  return ":<c-u>" .. "%s/" .. "<C-r>\"" .. "//"
end, { expr = true })

vim.keymap.set("n", "<leader>2c", function()
  return ":%s" .. "/_\\(\\w\\)" .. "/\\u\\1" .. "/gc<cr>"
end, { expr = true })

vim.keymap.set("v", "<leader>2c", function()
  return ":s" .. "/_\\(\\w\\)" .. "/\\u\\1" .. "/<cr>"
end, { expr = true })

vim.keymap.set("n", "<leader>c2c", function()
  return "viw:s" .. "/_\\(\\w\\)" .. "/\\u\\1" .. "/g<cr>"
end, { expr = true })

vim.keymap.set("n", "<leader>2u", function()
  return ":%s" .. "/\\(\\l\\)\\(\\u\\)" .. "/\\1_\\l\\2" .. "/gc<cr>"
end, { expr = true })

vim.keymap.set("v", "<leader>2u", function()
  return ":s" .. "/\\(\\l\\)\\(\\u\\)" .. "/\\1_\\l\\2" .. "/g<cr>"
end, { expr = true })

vim.keymap.set("n", "<leader>u2u", function()
  return "viw:s" .. "/\\(\\l\\)\\(\\u\\)" .. "/\\1_\\l\\2" .. "/g<cr>"
end, { expr = true })

vim.keymap.set("v", "<leader>rep", function()
  return "y:" .. "let @/=escape(@\", '/\')<cr>" .. ":%s/\\(" .. "<C-r>/" .. "\\)/\\1"
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

keymap("n", "<Leader>cr", ":%s/\\\\n/\\r/g<CR>:%s/\\\\t/\\t/g<CR>", desc('Format error logs with \n and \t characters'))

keymap("v", "gj", "Vygv<Esc>p", desc('Duplicate whole lines'))
keymap("n", "gj", "Vygv<Esc>p", desc('Duplicate whole lines'))

keymap("v", "gk", "Vy<Esc>P", desc('Duplicate whole lines'))
keymap("n", "gk", "Vy<Esc>P", desc('Duplicate whole lines'))

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
vim.keymap.set("", "<c-S>", function()
  return ":w " .. vim.fn.expand("%:p:h:F")
end, { expr = true })
vim.keymap.set("", "<Leader>S", function()
  return ":w " .. vim.fn.expand("%:p:h:F")
end, { expr = true })
-- vim.cmd [[ nmap <Leader>cp :let @+ = expand("%:p")<cr><esc> ]]
vim.keymap.set("", "<Leader>cp", function()
  return ":let @+=" .. "expand(\"%:p\")" .. "<cr>"
end, { expr = true })
