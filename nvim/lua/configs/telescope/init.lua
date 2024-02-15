local M = {}

function M.setup()
  local builtin = require('telescope.builtin')
  local utils = require('m_utils')

  vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
  vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
  vim.keymap.set('v', '<leader><leader>', function()
    local text = utils.get_visual_selection()
    builtin.find_files()

    vim.defer_fn(function()
      vim.cmd([[call feedkeys(text .. "\<Esc>", 'n')]])
    end, 100)
  end, {})

  vim.keymap.set('n', '<leader>fr', function()
    builtin.grep_string({ search = vim.fn.input("Grep : ") });
    vim.cmd([[call feedkeys("\<Esc>", 'n')]])
  end, { desc = "Find in Project" })
  vim.keymap.set('n', 'gh', function()
    builtin.grep_string({ search = vim.fn.input("Grep : ") });
    vim.cmd([[call feedkeys("\<Esc>", 'n')]])
  end, { desc = "Find in Project" })

  vim.keymap.set('v', 'gh', function()
    local text = utils.get_visual_selection()
    builtin.grep_string({ default_text = text })
    vim.cmd([[call feedkeys("\<Esc>", 'n')]])
  end, { desc = "Find in Project" })

  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

  -- vim.keymap.set('n', 'mr', builtin.buffers, {})
  vim.keymap.set('n', 'mr', ":lua require('telescope.builtin').buffers()<cr><esc>", {})

  vim.keymap.set('n', '<leader>,', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  vim.keymap.set('n', '<leader>fc', builtin.command_history, {})

  -- themes
  vim.keymap.set('n', '<leader>th', builtin.colorscheme, {})

  vim.keymap.set('n', '<leader>fauto', builtin.autocommands, {})
  vim.keymap.set({ 'n', 'v' }, '<leader>reg', builtin.registers, {})
  require('telescope').setup {
    defaults = {
      -- path_display = { shorten = { len = 1 } }
      path_display = { "shorten" }
    },
    pickers = {
      buffers = {
        sort_lastused = true
      }
    }
  }
end

return M
