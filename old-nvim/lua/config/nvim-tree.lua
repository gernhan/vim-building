-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_auto_close = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
-- require("nvim-tree").setup()
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { desc = "Toggle Nvim Tree" })
vim.keymap.set("n", "gf", function()
  vim.fn.execute('NvimTreeClose')
  vim.fn.execute('NvimTreeFindFileToggle')
end, { desc = "Display this file in Nvim Tree" })

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- override a default
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', 't', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'md', api.node.navigate.parent_close, opts('Collapse'))
  vim.keymap.set('n', 'x', api.node.navigate.parent_close, opts('Collapse'))
  vim.keymap.set('n', 'X', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'O', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 't', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'cd', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'v', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'p', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', '<C-e>', api.tree.reload, opts('Refresh'))
end

return my_on_attach
