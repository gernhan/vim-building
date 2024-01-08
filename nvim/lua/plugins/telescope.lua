-- plugins/telescope.lua:
return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      local utils = require('m_utils')

      vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})

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
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      -- This is your opts table
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      }
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
    end
  }
}
