local M = {}

function M.setup()
  require('telescope').setup {
    defaults = {
      -- path_display = { shorten = { len = 1 } }
      path_display = { "shorten" }
    },
    pickers = {
      buffers = {
        sort_lastused = true
      },
      find_files = {
        theme = "dropdown",
      },
      git_files = {
        theme = "dropdown",
      },
      grep_string = {
        theme = "dropdown",
      },
      command_history = {
        theme = "dropdown",
      },
      help_tags = {
        theme = "dropdown",
      },
      colorscheme = {
        theme = "dropdown",
      },
      autocommands = {
        theme = "dropdown",
      },
      registers = {
        theme = "dropdown",
      },
    }
  }

  local builtin = require('telescope.builtin')
  local utils = require('m_utils')

  vim.keymap.set('n', '<leader>ff', function()
    local more_args = vim.fn.input("More args `find_command=rg,-L,--files,(...)`, choose in (--hidden,--ignore) : ")
    if (not utils.is_empty(more_args)) then
      more_args = ',' .. more_args
    else
      more_args = ""
    end

    local command = 'Telescope find_files find_command=rg,-L,--files' .. more_args
    utils.log(command)
    vim.cmd(command)
  end, {})
  vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
  vim.keymap.set('n', '<leader><leader>', function()
    local command = 'Telescope find_files find_command=rg,--ignore,-L,--hidden,--files prompt_prefix=🔍'
    vim.cmd(command)
  end, {})
  vim.keymap.set('v', '<leader><leader>', function()
    local text = utils.get_visual_selection()
    local command = 'Telescope find_files find_command=rg,--ignore,-L,--hidden,--files prompt_prefix=🔍'
    vim.cmd(command)

    vim.defer_fn(function()
      vim.api.nvim_feedkeys(text, "n", false)
      -- vim.cmd([[call feedkeys("\<Esc>", 'n')]])
    end, 100)
  end, {})

  vim.keymap.set('n', '<leader>fl', function()
    builtin.live_grep();
    -- vim.cmd([[call feedkeys("\<Esc>", 'n')]])
  end, { desc = "Find in Project" })

  vim.keymap.set('n', 'gh', function()
    -- Retrieve the text from register 'g'
    local saved_text = vim.fn.getreg('g', 1)
    -- Use the saved text to perform a search
    local search_text = vim.fn.input("Grep : ")
    if search_text == "" then
      search_text = saved_text
    end
    vim.fn.setreg('g', search_text)

    builtin.grep_string({ search = search_text });
    -- vim.cmd([[call feedkeys("\<Esc>", 'n')]])
  end, { desc = "Find in Project" })

  vim.keymap.set('v', 'gh', function()
    local text = utils.get_visual_selection()
    -- Save the text in a unique register, e.g., register 'g'
    vim.fn.setreg('g', text)
    builtin.grep_string({ default_text = text })
    -- Insert an escape keypress to exit from visual mode
    -- vim.cmd([[call feedkeys("\<Esc>", 'n')]])
  end, { desc = "Find in Project" })

  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

  -- vim.keymap.set('n', 'mr', builtin.buffers, {})
  vim.keymap.set('n', 'mr', ":lua require('telescope.builtin').buffers()<cr><esc>", {})
  -- vim.keymap.set('n', '<leader>,', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  vim.keymap.set({ 'n', 'v' }, '<leader>fco', ":lua require('telescope.builtin').command_history()<cr><esc>", {})

  -- themes
  vim.keymap.set({ 'n', 'v' }, '<leader>th', ":lua require('telescope.builtin').colorscheme()<cr><esc>", {})
  vim.keymap.set({ 'n', 'v' }, '<leader>reg', ":lua require('telescope.builtin').colorscheme()<cr><esc>", {})

  vim.keymap.set({ 'n', 'v' }, '<leader>fauto', ":lua require('telescope.builtin').autocommands()<cr><esc>", {})
  vim.keymap.set({ 'n', 'v' }, '<leader>freg', ":lua require('telescope.builtin').registers()<cr><esc>", {})
  vim.keymap.set({ 'n', 'v' }, '<leader>fcc', ":lua require('telescope.builtin').resume()<cr><esc>", {})
end

return M
