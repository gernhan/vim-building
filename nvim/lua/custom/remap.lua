local m_utils = require "m_utils"
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>wd", ":q<cr>", { desc = "Close tab/window" })
vim.keymap.set("n", "<leader>ww", "<c-w>p", { desc = "Back to last tab/window" })

vim.keymap.set("n", "<leader>ss", ":w<cr>", { desc = "Save" })
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
vim.keymap.set("n", "<leader>nn", ":tabnew<cr>", { desc = "New File" })

local function desc(description)
  return { noremap = true, silent = true, desc = description }
end
local expr_opts = { noremap = true, expr = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>bb", ":b#<cr>", desc("Back to the last file"))
keymap("n", "<leader>bd", ":NvimTreeClose<cr>:bd<cr>", desc("Close tab"))
-- keymap("n", "<leader>bd", ":Bdelete<cr>", desc("Close tab"))
keymap("n", "<leader>dd", ":Bdelete<cr>", desc("Close tab"))
keymap("n", "<leader>qd", ":bd<cr>", desc("Close tab without closing nvim-tree"))
keymap("n", "<leader>qq", ":qa<cr>", desc("Close all tabs and quit"))

keymap("n", "<c-a>", "ggVG", desc("Select all"))

-- Better escape using jk in insert and terminal mode
-- keymap("i", "jk", "<ESC>", desc(""))
-- keymap("i", "jj", "<ESC>", desc(""))
-- keymap("t", "jk", "<C-\\><C-n>", desc(""))
-- keymap("t", "jk", "<C-\\><C-n>", desc(""))

-- Center search results
keymap("n", "n", "nzz", desc("Next matched"))
keymap("n", "N", "Nzz", desc("Previous matched"))

vim.keymap.set("n", "<leader>rep", function()
  return ":<c-u>" .. "%s/" .. "<C-r>\"" .. "//"
end, { expr = true, desc = "Replace with template" })

vim.keymap.set("n", "<leader>2c", function()
  return ":%s" .. "/_\\(\\w\\)" .. "/\\u\\1" .. "/gc<cr>"
end, { expr = true, desc = "To camel case" })

vim.keymap.set("v", "<leader>2c", function()
  return ":s" .. "/_\\(\\w\\)" .. "/\\u\\1" .. "/<cr>"
end, { expr = true, desc = "To camel case" })

vim.keymap.set("n", "<leader>c2c", function()
  return "viw:s" .. "/_\\(\\w\\)" .. "/\\u\\1" .. "/g<cr>"
end, { expr = true, desc = "To camel case" })

vim.keymap.set("n", "<leader>2u", function()
  return ":%s" .. "/\\(\\l\\)\\(\\u\\)" .. "/\\1_\\l\\2" .. "/gc<cr>"
end, { expr = true, desc = "To snake case" })

vim.keymap.set("v", "<leader>2u", function()
  return ":s" .. "/\\(\\l\\)\\(\\u\\)" .. "/\\1_\\l\\2" .. "/g<cr>"
end, { expr = true })

vim.keymap.set("n", "<leader>u2u", function()
  return "viw:s" .. "/\\(\\l\\)\\(\\u\\)" .. "/\\1_\\l\\2" .. "/g<cr>"
end, { expr = true })

vim.keymap.set("v", "<leader>rep", function()
  return "y:" .. "let @/=escape(@\", '/\')<cr>" .. ":%s/\\(" .. "<C-r>/" .. "\\)/\\1"
end, { expr = true, desc = "Replace yanked text" })

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", desc("Selected text to the left"))
keymap("v", ">", ">gv", desc("Selected text to the right"))

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', desc("Paste without yanking"))

-- Switch buffer
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", desc("Previous buffer"))
vim.keymap.set("n", "<S-l>", ":bnext<CR>", desc("Next buffer"))

vim.keymap.set({ "v", "t" }, "<S-l>", ":bnext<CR>", desc("Next buffer"))

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", desc("Cancel search highlighting"))

-- Move selected line / block of text in visual mode
keymap("x", "J", ":move '>+1<CR>gv-gv", desc("Move selected lines down"))
keymap("x", "K", ":move '<-2<CR>gv-gv", desc("Move selected lines up"))

keymap("n", "<Leader>cr", ":%s/\\\\n/\\r/g<CR>:%s/\\\\t/\\t/g<CR>", desc('Format error logs with \n and \t characters'))

keymap("v", "gj", "Vygv<Esc>p", desc('Duplicate whole lines'))
keymap("n", "gj", "Vygv<Esc>p", desc('Duplicate whole lines'))

keymap("v", "gk", "Vy<Esc>P", desc('Duplicate whole lines'))
keymap("n", "gk", "Vy<Esc>P", desc('Duplicate whole lines'))

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", desc("Expand vertically"))
keymap("n", "<Right>", ":vertical resize -1<CR>", desc("Collapse vertically"))
keymap("n", "<Up>", ":resize -1<CR>", desc("Collapse horizontally"))
keymap("n", "<Down>", ":resize +1<CR>", desc("Expand horizontally"))

keymap("n", "<leader>sv", ":vsplit<CR>", desc("Split vertically"))
keymap("n", "<leader>sh", ":split<CR>", desc("Split horizontally"))

vim.keymap.set("t", "<leader><Esc>", "<c-\\><c-n>", desc("From terminal context to Normal editor mode"))
keymap("n", "<leader>tt", ":terminal<CR>", desc("Call for a new terminal"))
keymap("t", "<leader>tx", "<c-\\><c-n>:bd!<cr>", desc("Kill terminal"))
keymap("t", "<leader>kkk", "<c-\\><c-n>:bd!<cr>", desc("Kill terminal"))
keymap("n", "<leader>kkk", ":bd!<cr>", desc("Kill terminal"))
vim.keymap.set("n", "<leader>it", function()
  return ":e " .. vim.fn.expand("%:p:h") .. "/"
end, { expr = true, desc = "Open a file" })
vim.keymap.set("", "<c-S>", function()
  return ":w " .. vim.fn.expand("%:p:h:F")
end, { expr = true, desc = "Save as" })
vim.keymap.set("", "<Leader>S", function()
  return ":w " .. vim.fn.expand("%:p:h:F")
end, { expr = true, desc = "Save as" })
-- vim.cmd [[ nmap <Leader>cp :let @+ = expand("%:p")<cr><esc> ]]
vim.keymap.set("", "<Leader>cp", m_utils.copy_absolute_path, { desc = "Copy path of this file" })
