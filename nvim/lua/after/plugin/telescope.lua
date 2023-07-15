local builtin = require('telescope.builtin')
local utils = require('utils')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})

vim.keymap.set('n', '<leader>fr', function()
  builtin.grep_string({search = vim.fn.input("Grep > ")});
end, {desc = "Find in Project"})
vim.keymap.set('n', 'gh', function()
  builtin.grep_string({search = vim.fn.input("Grep > ")});
end, {desc = "Find in Project"})

vim.keymap.set('v', 'gh', function()
  local text = utils.get_visual_selection()
  builtin.grep_string({ default_text = text })
end, {desc = "Find in Project"})

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', 'mr', builtin.buffers, {})
vim.keymap.set('n', '<leader>,', builtin.buffers, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fc', builtin.command_history, {})

-- themes
vim.keymap.set('n', '<leader>th', builtin.colorscheme, {})

vim.keymap.set('n', '<leader>fauto', builtin.autocommands, {})
vim.keymap.set('n', '<leader>reg', builtin.registers, {})
vim.keymap.set('n', 'gp', builtin.registers, {})
require('telescope.actions')require('telescope').setup {
  pickers = {
    buffers = {
      sort_lastused = true
    }
  }
}
